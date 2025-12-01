//
//  NowPlayingProView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct NowPlayingProView: View {
    @EnvironmentObject var appState: AppState
    @State private var playbackTimer: Timer?
    @Environment(\.dismiss) var dismiss
    
    var currentTrack: Track? {
        appState.currentTrack
    }
    
    var isPlaying: Bool {
        appState.isPlaying
    }
    
    var currentTime: Double {
        appState.currentTime
    }
    
    var totalTime: Double {
        currentTrack?.duration ?? 90
    }
    
    var body: some View {
        ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("Now Playing")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    
                    // Album Art
                    ZStack(alignment: .topTrailing) {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.8, green: 0.3, blue: 0.9),
                                        Color(red: 1.0, green: 0.4, blue: 0.6),
                                        Color(red: 1.0, green: 0.5, blue: 0.0),
                                        Color(red: 0.2, green: 0.8, blue: 0.6),
                                        Color(red: 0.2, green: 0.6, blue: 1.0)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 350)
                        
                        HStack {
                            Spacer()
                            
                            HStack(spacing: 6) {
                                Image(systemName: "questionmark.circle.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                
                                Text("HQ Audio")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.green)
                            .cornerRadius(20)
                            .padding()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Track Info
                    if let track = currentTrack {
                        VStack(spacing: 12) {
                            Text(track.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Generated \(track.timeAgo)")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 8) {
                                TrackTag(text: track.genre, color: Color(red: 0.6, green: 0.2, blue: 1.0).opacity(0.2), textColor: Color(red: 0.6, green: 0.2, blue: 1.0))
                                TrackTag(text: track.mood, color: Color(red: 1.0, green: 0.5, blue: 0.0).opacity(0.2), textColor: Color(red: 1.0, green: 0.5, blue: 0.0))
                            
                            HStack(spacing: 4) {
                                Image(systemName: "clock.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(.green)
                                Text("1:30")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(.green)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Progress Bar
                    VStack(spacing: 8) {
                        ProgressView(value: currentTime, total: totalTime)
                            .tint(
                                LinearGradient(
                                    colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 1.0, green: 0.5, blue: 0.0)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        HStack {
                            Text(timeString(from: currentTime))
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text(timeString(from: totalTime))
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Playback Controls
                    VStack(spacing: 20) {
                        HStack(spacing: 32) {
                            Button(action: {}) {
                                Image(systemName: "backward.end.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                            
                            Button(action: {
                                if isPlaying {
                                    appState.pauseTrack()
                                } else {
                                    if let track = currentTrack {
                                        appState.playTrack(track)
                                    } else {
                                        appState.resumeTrack()
                                    }
                                }
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 1.0, green: 0.5, blue: 0.0)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 70, height: 70)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                        .font(.system(size: 28))
                                        .foregroundColor(.white)
                                }
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "forward.end.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        HStack(spacing: 24) {
                            Button(action: {}) {
                                Image(systemName: "shuffle")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "repeat")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Share Button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "square.and.arrow.up.fill")
                                .font(.system(size: 18))
                            Text("Share Your Creation")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Track Details
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Track Details")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            DetailRow(label: "Quality", value: "High Definition", hasDot: true, dotColor: .green)
                            DetailRow(label: "Sample Rate", value: "48 kHz")
                            DetailRow(label: "Bit Depth", value: "24-bit")
                            DetailRow(label: "Format", value: "WAV")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(white: 0.8), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Audio Features
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Audio Features")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            FeatureCard(icon: "drum.fill", text: "85 BPM", title: "Tempo", color: Color(red: 0.6, green: 0.2, blue: 1.0))
                            FeatureCard(icon: "music.note", text: "C Minor", title: "Key", color: Color(red: 1.0, green: 0.4, blue: 0.6))
                            FeatureCard(icon: "bolt.fill", text: "Low", title: "Energy", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                            FeatureCard(icon: "face.smiling", text: "Calm", title: "Mood", color: Color(red: 0.2, green: 0.6, blue: 1.0))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Download Options
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Download Options")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            DownloadOptionRow(
                                icon: "arrow.down.circle.fill",
                                title: "High Quality WAV",
                                subtitle: "Uncompressed, 24-bit",
                                color: .green
                            )
                            
                            DownloadOptionRow(
                                icon: "arrow.down.circle.fill",
                                title: "MP3 320kbps",
                                subtitle: "High quality, smaller file",
                                color: Color(red: 0.6, green: 0.2, blue: 1.0)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Original Prompt
                    if let track = currentTrack {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "quote.opening")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color(red: 0.6, green: 0.2, blue: 1.0))
                                
                                Text(track.prompt)
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(white: 0.8), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                    
                    // Similar Tracks
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Similar Tracks")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Text("See All")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.6))
                            }
                        }
                        
                        VStack(spacing: 12) {
                            SimilarTrackRow(
                                icon: "headphones",
                                title: "Midnight Study",
                                tags: "Lofi • Calm",
                                duration: "HQ 1:45",
                                gradient: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 1.0, green: 0.4, blue: 0.6)]
                            )
                            
                            SimilarTrackRow(
                                icon: "moon.fill",
                                title: "Rainy Evening",
                                tags: "Ambient • Relaxing",
                                duration: "HQ 2:00",
                                gradient: [Color(red: 0.2, green: 0.6, blue: 1.0), Color(red: 0.6, green: 0.2, blue: 1.0)]
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Generation Info
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Generation Info")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            DetailRow(label: "Generated", value: "2 hours ago")
                            DetailRow(label: "Processing Time", value: "Instant")
                            DetailRow(label: "Model Version", value: "v3.5")
                            DetailRow(label: "Copyright", value: "Royalty-free")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(white: 0.8), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Premium Benefits Active
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            Image(systemName: "crown.fill")
                                .foregroundColor(Color(red: 1.0, green: 0.5, blue: 0.0))
                                .font(.system(size: 24))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Premium Benefits Active")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text("Enjoying your Pro subscription")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        VStack(spacing: 12) {
                            PremiumBenefitRow(text: "No watermark on album art")
                            PremiumBenefitRow(text: "High-definition audio quality")
                            PremiumBenefitRow(text: "Instant generation with no wait")
                            PremiumBenefitRow(text: "Multiple download formats")
                        }
                    }
                    .padding()
                    .background(Color(red: 1.0, green: 0.95, blue: 1.0))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
            .background(Color.white)
            .navigationBarHidden(true)
            .onAppear {
                if let track = currentTrack {
                    appState.playTrack(track)
                }
                startPlaybackTimer()
            }
            .onDisappear {
                stopPlaybackTimer()
            }
            .onChange(of: isPlaying) { oldValue, newValue in
                if newValue {
                    startPlaybackTimer()
                } else {
                    stopPlaybackTimer()
                }
            }
        }
    }
    
    private func startPlaybackTimer() {
        stopPlaybackTimer()
        playbackTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if isPlaying, let track = currentTrack {
                let newTime = currentTime + 0.1
                if newTime < track.duration {
                    appState.updatePlaybackTime(newTime)
                } else {
                    appState.stopTrack()
                }
            }
        }
    }
    
    private func stopPlaybackTimer() {
        playbackTimer?.invalidate()
        playbackTimer = nil
    }
    
    func timeString(from seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, secs)
    }
}

struct TrackTag: View {
    let text: String
    let color: Color
    var textColor: Color = .black
    
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .foregroundColor(textColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color)
            .cornerRadius(12)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    var hasDot: Bool = false
    var dotColor: Color = .green
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack(spacing: 6) {
                if hasDot {
                    Circle()
                        .fill(dotColor)
                        .frame(width: 6, height: 6)
                }
                
                Text(value)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
    }
}

struct FeatureCard: View {
    let icon: String
    let text: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
            
            Text(text)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(white: 0.8), lineWidth: 1)
        )
    }
}

struct DownloadOptionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "arrow.down.circle.fill")
                .foregroundColor(color)
                .font(.system(size: 20))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(white: 0.8), lineWidth: 1)
        )
    }
}

struct SimilarTrackRow: View {
    let icon: String
    let title: String
    let tags: String
    let duration: String
    let gradient: [Color]
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(tags)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text(duration)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "play.fill")
                    .foregroundColor(Color(red: 0.6, green: 0.2, blue: 1.0))
                    .font(.system(size: 16))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(white: 0.8), lineWidth: 1)
        )
    }
}

struct PremiumBenefitRow: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 16))
            
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    NowPlayingProView()
        .environmentObject(AppState())
}

