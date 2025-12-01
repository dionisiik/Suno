//
//  Models.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import Foundation
import SwiftUI

// MARK: - Track Model
struct Track: Identifiable, Codable {
    let id: String
    var title: String
    var prompt: String
    var duration: TimeInterval
    var createdAt: Date
    var genre: String
    var mood: String
    var quality: AudioQuality
    var isFavorite: Bool
    var isDownloaded: Bool
    var icon: String
    var gradientColors: [String]
    
    enum AudioQuality: String, Codable {
        case standard = "Standard"
        case hq = "HQ"
        
        var bitrate: String {
            switch self {
            case .standard: return "128 kbps"
            case .hq: return "320 kbps"
            }
        }
    }
    
    init(
        id: String = UUID().uuidString,
        title: String,
        prompt: String,
        duration: TimeInterval,
        createdAt: Date = Date(),
        genre: String = "Auto-detect",
        mood: String = "Calm",
        quality: AudioQuality = .standard,
        isFavorite: Bool = false,
        isDownloaded: Bool = false,
        icon: String = "music.note",
        gradientColors: [String] = []
    ) {
        self.id = id
        self.title = title
        self.prompt = prompt
        self.duration = duration
        self.createdAt = createdAt
        self.genre = genre
        self.mood = mood
        self.quality = quality
        self.isFavorite = isFavorite
        self.isDownloaded = isDownloaded
        self.icon = icon
        self.gradientColors = gradientColors
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: createdAt, relativeTo: Date())
    }
    
    var durationString: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        if minutes > 0 {
            return "\(minutes)m \(seconds)s"
        } else {
            return "\(seconds)s"
        }
    }
}

// MARK: - User Model
struct User: Codable {
    var name: String
    var email: String
    var isPro: Bool
    var dailyCredits: Int
    var maxDailyCredits: Int
    var dayStreak: Int
    var totalTracksCreated: Int
    var totalDuration: TimeInterval
    
    init(
        name: String = "Sarah",
        email: String = "sarah@example.com",
        isPro: Bool = true,
        dailyCredits: Int = 5,
        maxDailyCredits: Int = 5,
        dayStreak: Int = 5,
        totalTracksCreated: Int = 24,
        totalDuration: TimeInterval = 1440
    ) {
        self.name = name
        self.email = email
        self.isPro = isPro
        self.dailyCredits = dailyCredits
        self.maxDailyCredits = maxDailyCredits
        self.dayStreak = dayStreak
        self.totalTracksCreated = totalTracksCreated
        self.totalDuration = totalDuration
    }
}

// MARK: - Generation Request
struct GenerationRequest: Codable {
    var prompt: String
    var genre: String
    var mood: String?
    var duration: TimeInterval
    var quality: Track.AudioQuality
    var instruments: [String]
    
    init(
        prompt: String = "",
        genre: String = "Auto-detect",
        mood: String? = nil,
        duration: TimeInterval = 30,
        quality: Track.AudioQuality = .hq,
        instruments: [String] = []
    ) {
        self.prompt = prompt
        self.genre = genre
        self.mood = mood
        self.duration = duration
        self.quality = quality
        self.instruments = instruments
    }
}

// MARK: - Generation Status
enum GenerationStatus: Equatable {
    case idle
    case analyzing
    case composing
    case rendering
    case generatingArt
    case completed
    case failed(String)
    
    var progress: Double {
        switch self {
        case .idle: return 0.0
        case .analyzing: return 0.25
        case .composing: return 0.5
        case .rendering: return 0.75
        case .generatingArt: return 0.9
        case .completed: return 1.0
        case .failed: return 0.0
        }
    }
    
    var description: String {
        switch self {
        case .idle: return "Ready to generate"
        case .analyzing: return "Analyzing prompt"
        case .composing: return "Composing music"
        case .rendering: return "Rendering HQ audio"
        case .generatingArt: return "Generating cover art"
        case .completed: return "Complete! Your music is ready"
        case .failed(let error): return "Failed: \(error)"
        }
    }
    
    var detail: String {
        switch self {
        case .idle: return ""
        case .analyzing: return "Understanding your creative vision"
        case .composing: return "AI is creating your melody"
        case .rendering: return "Finalizing studio-quality output"
        case .generatingArt: return "Creating visual representation"
        case .completed: return ""
        case .failed: return ""
        }
    }
}

