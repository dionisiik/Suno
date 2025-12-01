//
//  AppState.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import Foundation
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var user: User
    @Published var tracks: [Track] = []
    @Published var currentTrack: Track?
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
    @Published var generationRequest: GenerationRequest?
    @Published var generationStatus: GenerationStatus = .idle
    @Published var selectedTab: Int = 0
    @Published var isAuthenticated: Bool = false
    
    // Sample tracks for demo
    init() {
        self.user = User()
        
        // Initialize with sample tracks
        self.tracks = [
            Track(
                title: "Chill Lofi Beats",
                prompt: "A peaceful lofi hip hop beat with soft piano melodies",
                duration: 30,
                createdAt: Date().addingTimeInterval(-7200),
                genre: "Lofi",
                mood: "Calm",
                quality: .hq,
                icon: "headphones",
                gradientColors: ["0.6,0.2,1.0", "1.0,0.4,0.6"]
            ),
            Track(
                title: "Acoustic Sunrise",
                prompt: "Acoustic guitar melody with warm morning vibes",
                duration: 60,
                createdAt: Date().addingTimeInterval(-86400),
                genre: "Acoustic",
                mood: "Happy",
                quality: .hq,
                icon: "guitars",
                gradientColors: ["0.2,0.8,0.6", "0.2,0.8,0.8"]
            ),
            Track(
                title: "Epic Battle Theme",
                prompt: "Epic orchestral battle music with drums",
                duration: 120,
                createdAt: Date().addingTimeInterval(-172800),
                genre: "Epic",
                mood: "Epic",
                quality: .hq,
                icon: "drum.fill",
                gradientColors: ["1.0,0.0,0.0", "1.0,0.4,0.6"]
            ),
            Track(
                title: "Jazz Night Vibes",
                prompt: "Smooth jazz with saxophone and piano",
                duration: 90,
                createdAt: Date().addingTimeInterval(-259200),
                genre: "Jazz",
                mood: "Chill",
                quality: .hq,
                icon: "music.note",
                gradientColors: ["0.2,0.6,1.0", "0.6,0.2,1.0"]
            )
        ]
    }
    
    // MARK: - Track Management
    func addTrack(_ track: Track) {
        tracks.insert(track, at: 0)
        user.totalTracksCreated += 1
        user.totalDuration += track.duration
    }
    
    func deleteTrack(_ track: Track) {
        tracks.removeAll { $0.id == track.id }
        user.totalDuration -= track.duration
        if currentTrack?.id == track.id {
            currentTrack = nil
            isPlaying = false
        }
    }
    
    func toggleFavorite(_ track: Track) {
        if let index = tracks.firstIndex(where: { $0.id == track.id }) {
            tracks[index].isFavorite.toggle()
        }
        if currentTrack?.id == track.id {
            currentTrack?.isFavorite.toggle()
        }
    }
    
    func duplicateTrack(_ track: Track) {
        var newTrack = track
        newTrack = Track(
            title: "\(track.title) (Copy)",
            prompt: track.prompt,
            duration: track.duration,
            createdAt: Date(),
            genre: track.genre,
            mood: track.mood,
            quality: track.quality,
            icon: track.icon,
            gradientColors: track.gradientColors
        )
        addTrack(newTrack)
    }
    
    // MARK: - Playback
    func playTrack(_ track: Track) {
        currentTrack = track
        isPlaying = true
        currentTime = 0
    }
    
    func pauseTrack() {
        isPlaying = false
    }
    
    func resumeTrack() {
        if currentTrack != nil {
            isPlaying = true
        }
    }
    
    func stopTrack() {
        isPlaying = false
        currentTime = 0
    }
    
    func updatePlaybackTime(_ time: TimeInterval) {
        currentTime = time
        if let track = currentTrack, currentTime >= track.duration {
            stopTrack()
        }
    }
    
    // MARK: - Generation
    func startGeneration(_ request: GenerationRequest) {
        guard user.isPro || user.dailyCredits > 0 else {
            generationStatus = .failed("No credits remaining")
            return
        }
        
        generationRequest = request
        generationStatus = .analyzing
        
        // Simulate generation process
        simulateGeneration()
    }
    
    private func simulateGeneration() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.generationStatus = .composing
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.generationStatus = .rendering
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.generationStatus = .generatingArt
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.completeGeneration()
        }
    }
    
    private func completeGeneration() {
        guard let request = generationRequest else { return }
        
        // Create new track
        let icons = ["headphones", "guitars", "drum.fill", "music.note", "piano", "music.mic"]
        let gradients = [
            ["0.6,0.2,1.0", "1.0,0.4,0.6"],
            ["0.2,0.8,0.6", "0.2,0.8,0.8"],
            ["1.0,0.0,0.0", "1.0,0.4,0.6"],
            ["0.2,0.6,1.0", "0.6,0.2,1.0"],
            ["1.0,0.9,0.8", "1.0,0.7,0.9"],
            ["1.0,0.5,0.0", "0.8,0.3,0.9"]
        ]
        
        let randomIcon = icons.randomElement() ?? "music.note"
        let randomGradient = gradients.randomElement() ?? ["0.6,0.2,1.0", "1.0,0.4,0.6"]
        
        let newTrack = Track(
            title: generateTitle(from: request.prompt),
            prompt: request.prompt,
            duration: request.duration,
            createdAt: Date(),
            genre: request.genre,
            mood: request.mood ?? "Calm",
            quality: request.quality,
            icon: randomIcon,
            gradientColors: randomGradient
        )
        
        addTrack(newTrack)
        
        if !user.isPro {
            user.dailyCredits -= 1
        }
        
        generationStatus = .completed
        generationRequest = nil
        
        // Auto navigate to the new track after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.currentTrack = newTrack
        }
    }
    
    private func generateTitle(from prompt: String) -> String {
        let words = prompt.components(separatedBy: " ")
        if words.count >= 2 {
            return "\(words[0].capitalized) \(words[1].capitalized)"
        }
        return prompt.prefix(20).capitalized
    }
    
    func cancelGeneration() {
        generationStatus = .idle
        generationRequest = nil
    }
    
    // MARK: - Authentication
    func login(email: String, password: String) -> Bool {
        // Simple authentication: admin/admin1
        if email.lowercased() == "admin" && password == "admin1" {
            isAuthenticated = true
            return true
        }
        return false
    }
    
    func logout() {
        isAuthenticated = false
        stopTrack()
        currentTrack = nil
    }
    
    // MARK: - Filtering
    func filteredTracks(filter: String) -> [Track] {
        switch filter {
        case "Recent":
            return tracks.sorted { $0.createdAt > $1.createdAt }
        case "Favorites":
            return tracks.filter { $0.isFavorite }
        case "Downloads":
            return tracks.filter { $0.isDownloaded }
        default:
            return tracks
        }
    }
}

