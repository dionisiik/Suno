//
//  NowPlayingView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct NowPlayingView: View {
    @EnvironmentObject var appState: AppState
    @State private var volume: Double = 0.7
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
        currentTrack?.duration ?? 30
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Button(action: { dismiss() }) {
                            ZStack {
                                Circle()
                                    .fill(Color(white: 0.9))
                                    .frame(width: 36, height: 36)
                                
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Spacer()
                        
                        Text("Now Playing")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            ZStack {
                                Circle()
                                    .fill(Color(white: 0.9))
                                    .frame(width: 36, height: 36)
                                
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    
                    // Album Art
                    ZStack(alignment: .topLeading) {
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
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color(white: 0.8), lineWidth: 1)
                            )
                        
                        VStack {
                            HStack {
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(Color(red: 1.0, green: 0.4, blue: 0.6))
                                        .frame(width: 6, height: 6)
                                    
                                    Text("Standard Quality")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.black)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(20)
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    Text("MusicAI")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(12)
                            }
                            .padding()
                            
                            Spacer()
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
                            
                            Text("AI Generated Track")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 8) {
                                Tag(text: track.genre, color: Color(white: 0.9))
                                Tag(text: track.mood, color: Color(white: 0.9))
                                Tag(text: track.durationString, color: Color(red: 1.0, green: 0.5, blue: 0.0))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                    
                    // Waveform Placeholder
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 1.0, green: 0.9, blue: 0.8))
                        .frame(height: 60)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                    
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
                                Image(systemName: "shuffle")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                            
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
                            
                            Button(action: {}) {
                                Image(systemName: "repeat")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Volume Control
                        HStack(spacing: 12) {
                            Image(systemName: volume < 0.1 ? "speaker.fill" : "speaker.wave.2.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            
                            Slider(value: $volume)
                                .tint(Color(red: 0.2, green: 0.6, blue: 1.0))
                            
                            Image(systemName: "speaker.wave.3.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Share Button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 18))
                            Text("Share This Track")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 1.0, green: 0.5, blue: 0.0)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Upgrade Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Upgrade for Better Quality")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Text("Remove watermarks and get studio-quality audio")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Button(action: {}) {
                            Text("Try Pro Free for 3 Days")
                                .font(.system(size: 16, weight: .semibold))
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
                    }
                    .padding()
                    .background(Color(red: 0.98, green: 0.95, blue: 1.0))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                        // Action Buttons
                    if let track = currentTrack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ActionButton(
                                icon: "arrow.down.circle.fill",
                                title: "Download",
                                subtitle: "Save locally",
                                color: Color(red: 0.2, green: 0.6, blue: 1.0),
                                action: {
                                    // Download functionality
                                }
                            )
                            
                            ActionButton(
                                icon: "wand.and.stars",
                                title: "Remix",
                                subtitle: "Create variation",
                                gradient: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                action: {
                                    // Remix functionality
                                }
                            )
                            
                            ActionButton(
                                icon: "doc.on.doc.fill",
                                title: "Duplicate",
                                subtitle: "Make a copy",
                                color: .green,
                                action: {
                                    appState.duplicateTrack(track)
                                }
                            )
                            
                            ActionButton(
                                icon: "trash.fill",
                                title: "Delete",
                                subtitle: "Remove track",
                                color: Color(red: 1.0, green: 0.5, blue: 0.0),
                                action: {
                                    appState.deleteTrack(track)
                                    dismiss()
                                }
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                    
                    // Share On
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Share On")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        HStack(spacing: 16) {
                            SocialButton(icon: "f.circle.fill", color: Color(red: 0.2, green: 0.4, blue: 0.9))
                            SocialButton(icon: "camera.fill", gradient: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 1.0, green: 0.5, blue: 0.0)])
                            SocialButton(icon: "bird.fill", color: Color(red: 0.2, green: 0.7, blue: 1.0))
                            SocialButton(icon: "message.fill", color: .green)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
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

struct ActionButton: View {
    let icon: String
    let title: String
    let subtitle: String
    var color: Color? = nil
    var gradient: [Color]? = nil
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            gradient != nil ?
                            LinearGradient(colors: gradient!, startPoint: .topLeading, endPoint: .bottomTrailing) :
                            LinearGradient(colors: [color ?? .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(height: 80)
                    
                    Image(systemName: icon)
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(white: 0.8), lineWidth: 1)
            )
        }
    }
}

struct SocialButton: View {
    let icon: String
    var color: Color? = nil
    var gradient: [Color]? = nil
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        gradient != nil ?
                        LinearGradient(colors: gradient!, startPoint: .topLeading, endPoint: .bottomTrailing) :
                        LinearGradient(colors: [color ?? .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    NowPlayingView()
}

