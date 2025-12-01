//
//  HomeView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var prompt = ""
    @State private var selectedDuration = "30 sec"
    @State private var selectedQuality = "HQ"
    @State private var selectedMood: String? = nil
    @State private var selectedInstrument: String? = nil
    @State private var advancedOptionsExpanded = false
    @State private var showGenerationView = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Good Morning")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 4) {
                                Text("Hey, \(appState.user.name)!")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text("👋")
                                    .font(.system(size: 28))
                            }
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            if appState.user.isPro {
                                Button(action: {}) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "crown.fill")
                                            .font(.system(size: 12))
                                        Text("PRO")
                                            .font(.system(size: 14, weight: .bold))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        LinearGradient(
                                            colors: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 1.0, green: 0.4, blue: 0.6)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(20)
                                }
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "gearshape")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    
                    // Create Your Music Section
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: 100, height: 100)
                            
                            VStack(spacing: 4) {
                                Image(systemName: "wand.and.stars")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                
                                HStack(spacing: 2) {
                                    ForEach(0..<3) { _ in
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 8))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        
                        Text("Create Your Music")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Transform your ideas into stunning music with AI. Unlimited generations at your fingertips!")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 32)
                    
                    // Pro Member Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 1.0, green: 0.5, blue: 0.0))
                                    .frame(width: 40, height: 40)
                                
                                Text("S")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("You're a Pro Member!")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text("Enjoying all premium features")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        HStack(spacing: 12) {
                            ProTag(icon: "bolt.fill", text: "Instant", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                            ProTag(icon: "infinity", text: "Unlimited", color: Color(red: 0.6, green: 0.2, blue: 1.0))
                            ProTag(icon: "headphones", text: "HQ Audio", color: Color(red: 1.0, green: 0.4, blue: 0.6))
                            ProTag(icon: "checkmark.circle.fill", text: "No Marks", color: .green)
                        }
                    }
                    .padding(20)
                    .background(
                        LinearGradient(
                            colors: [Color(red: 1.0, green: 0.9, blue: 0.8), Color(red: 1.0, green: 0.85, blue: 0.9)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // What do you want to create?
                    VStack(alignment: .leading, spacing: 16) {
                        Text("What do you want to create?")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        TextEditor(text: $prompt)
                            .frame(height: 120)
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(white: 0.8), lineWidth: 1)
                            )
                            .overlay(
                                Group {
                                    if prompt.isEmpty {
                                        VStack {
                                            HStack {
                                                Text("E.g., A peaceful piano melody with soft rain sounds, perfect for studying...")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                                    .padding(.leading, 16)
                                                    .padding(.top, 20)
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                            )
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                GenreTag(icon: "bolt.fill", text: "Energetic Pop", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                                GenreTag(icon: "moon.fill", text: "Chill Lofi", color: Color(red: 0.2, green: 0.6, blue: 1.0))
                                GenreTag(icon: "guitars", text: "Acoustic", color: Color(red: 0.6, green: 0.4, blue: 0.2))
                                GenreTag(icon: "sword.fill", text: "Epic", color: .red)
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Advanced Options
                    VStack(alignment: .leading, spacing: 16) {
                        Button(action: { advancedOptionsExpanded.toggle() }) {
                            HStack {
                                Text("Advanced Options")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Image(systemName: advancedOptionsExpanded ? "chevron.down" : "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        if advancedOptionsExpanded {
                            // Genre Dropdown
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Genre")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                HStack {
                                    Text("Auto-detect")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(white: 0.8), lineWidth: 1)
                                )
                            }
                            
                            // Mood Selection
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Mood")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                    ForEach(["Happy", "Calm", "Energetic", "Sad", "Epic", "Dark", "Chill", "Relaxed", "Upbeat"], id: \.self) { mood in
                                        Button(action: { selectedMood = selectedMood == mood ? nil : mood }) {
                                            Text(mood)
                                                .font(.system(size: 13))
                                                .foregroundColor(selectedMood == mood ? Color(red: 1.0, green: 0.4, blue: 0.6) : .black)
                                                .frame(maxWidth: .infinity)
                                                .padding(.vertical, 10)
                                                .background(selectedMood == mood ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(selectedMood == mood ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: selectedMood == mood ? 2 : 1)
                                                )
                                        }
                                    }
                                }
                            }
                            
                            // Duration Selection
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Duration")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 12) {
                                    ForEach(["30 sec", "1 min", "2 min", "3 min"], id: \.self) { duration in
                                        Button(action: { selectedDuration = duration }) {
                                            Text(duration)
                                                .font(.system(size: 13))
                                                .foregroundColor(selectedDuration == duration ? Color(red: 1.0, green: 0.4, blue: 0.6) : .black)
                                                .frame(maxWidth: .infinity)
                                                .padding(.vertical, 10)
                                                .background(selectedDuration == duration ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(selectedDuration == duration ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: selectedDuration == duration ? 2 : 1)
                                                )
                                        }
                                    }
                                }
                            }
                            
                            // Audio Quality
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Audio Quality")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 12) {
                                    Button(action: { selectedQuality = "Standard" }) {
                                        Text("Standard")
                                            .font(.system(size: 13))
                                            .foregroundColor(selectedQuality == "Standard" ? Color(red: 1.0, green: 0.4, blue: 0.6) : .gray)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(selectedQuality == "Standard" ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(selectedQuality == "Standard" ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: selectedQuality == "Standard" ? 2 : 1)
                                            )
                                    }
                                    
                                    Button(action: { selectedQuality = "HQ" }) {
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 10))
                                                .foregroundColor(.yellow)
                                            Text("HQ")
                                                .font(.system(size: 13))
                                        }
                                        .foregroundColor(selectedQuality == "HQ" ? Color(red: 1.0, green: 0.4, blue: 0.6) : .black)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(selectedQuality == "HQ" ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(selectedQuality == "HQ" ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: selectedQuality == "HQ" ? 2 : 1)
                                        )
                                    }
                                }
                            }
                            
                            // Instruments
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Instruments (Optional)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                    ForEach(["🎹 Piano", "🎸 Guitar", "🥁 Drums", "🎻 Strings", "🎤 Vocals", "🎶 Synth"], id: \.self) { instrument in
                                        Button(action: { selectedInstrument = selectedInstrument == instrument ? nil : instrument }) {
                                            Text(instrument)
                                                .font(.system(size: 13))
                                                .foregroundColor(selectedInstrument == instrument ? Color(red: 1.0, green: 0.4, blue: 0.6) : .black)
                                                .frame(maxWidth: .infinity)
                                                .padding(.vertical, 10)
                                                .background(selectedInstrument == instrument ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(selectedInstrument == instrument ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: selectedInstrument == instrument ? 2 : 1)
                                                )
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Generate Instantly Button
                    VStack(spacing: 8) {
                        Button(action: {
                            startGeneration()
                        }) {
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 18))
                                Text("Generate Instantly")
                                    .font(.system(size: 18, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                        }
                        .disabled(prompt.isEmpty)
                        .opacity(prompt.isEmpty ? 0.6 : 1.0)
                        
                        Text("Priority processing • No queue • No watermarks")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    .sheet(isPresented: $showGenerationView) {
                        GenerationView()
                            .environmentObject(appState)
                    }
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Actions")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            QuickActionCard(
                                icon: "mic.fill",
                                title: "Voice Input",
                                subtitle: "Speak your idea",
                                gradient: [Color(red: 0.4, green: 0.8, blue: 1.0), Color.green]
                            )
                            
                            QuickActionCard(
                                icon: "wand.and.stars",
                                title: "Surprise Me",
                                subtitle: "Random creation",
                                gradient: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)]
                            )
                            
                            QuickActionCard(
                                icon: "doc.text",
                                title: "Remix",
                                subtitle: "Edit previous",
                                gradient: [Color(red: 1.0, green: 0.5, blue: 0.0), Color.yellow]
                            )
                            
                            QuickActionCard(
                                icon: "list.bullet",
                                title: "Templates",
                                subtitle: "Browse presets",
                                gradient: [Color.green, Color(red: 0.2, green: 0.8, blue: 0.8)]
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Recent Creations
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Creations")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Text("View All")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.6, green: 0.2, blue: 1.0))
                            }
                        }
                        
                        VStack(spacing: 12) {
                            ForEach(Array(appState.tracks.prefix(4))) { track in
                                CreationRow(
                                    track: track,
                                    onTap: {
                                        appState.playTrack(track)
                                    }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Pro Exclusive Features
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            Image(systemName: "crown.fill")
                                .foregroundColor(Color(red: 1.0, green: 0.5, blue: 0.0))
                                .font(.system(size: 24))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Pro Exclusive Features")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text("Only available for Pro members")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        VStack(spacing: 12) {
                            HomeProFeatureRow(icon: "arrow.down.circle.fill", text: "Export in Multiple Formats", detail: "MP3, WAV, FLAC & more", color: Color(red: 0.2, green: 0.6, blue: 1.0))
                            HomeProFeatureRow(icon: "slider.horizontal.3", text: "Advanced Audio Controls", detail: "Fine-tune every parameter", color: Color(red: 1.0, green: 0.4, blue: 0.6))
                            HomeProFeatureRow(icon: "cloud.fill", text: "Unlimited Cloud Storage", detail: "Save all your creations", color: .green)
                            HomeProFeatureRow(icon: "person.2.fill", text: "Collaboration Tools", detail: "Work with other creators", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                        }
                    }
                    .padding(20)
                    .background(
                        LinearGradient(
                            colors: [Color(red: 1.0, green: 0.9, blue: 0.95), Color(red: 0.95, green: 0.9, blue: 1.0)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Trending Templates
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Trending Templates")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Text("See More")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.6, green: 0.2, blue: 1.0))
                            }
                        }
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            TemplateCard(
                                icon: "cloud.fill",
                                title: "Dream Pop",
                                subtitle: "Ethereal & atmospheric",
                                color: Color(red: 0.4, green: 0.8, blue: 1.0)
                            )
                            
                            TemplateCard(
                                icon: "heart.fill",
                                title: "Romantic",
                                subtitle: "Soft & emotional",
                                color: Color(red: 1.0, green: 0.4, blue: 0.6)
                            )
                            
                            TemplateCard(
                                icon: "sun.max.fill",
                                title: "Summer Vibes",
                                subtitle: "Upbeat & tropical",
                                color: Color(red: 1.0, green: 0.5, blue: 0.0)
                            )
                            
                            TemplateCard(
                                icon: "leaf.fill",
                                title: "Nature Sounds",
                                subtitle: "Peaceful & organic",
                                color: .green
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Pro Tips
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Pro Tips for Better Results")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            TipCard(
                                icon: "lightbulb.fill",
                                title: "Be Specific",
                                description: "Include instruments, tempo, and mood for better results. Example: Upbeat acoustic guitar with soft drums, 126 BPM.",
                                color: Color(red: 0.2, green: 0.6, blue: 1.0)
                            )
                            
                            TipCard(
                                icon: "sparkles",
                                title: "Experiment with Genres",
                                description: "Try blending different genres to discover unique sounds. Mix classical with electronic or jazz with hip-hop!",
                                color: Color(red: 0.6, green: 0.2, blue: 1.0)
                            )
                            
                            TipCard(
                                icon: "percent",
                                title: "Use Advanced Controls",
                                description: "Take advantage of HQ audio settings and custom duration options for professional-quality output.",
                                color: .green
                            )
                            
                            TipCard(
                                icon: "square.and.arrow.up.fill",
                                title: "Share & Collaborate",
                                description: "Share your creations with the community for feedback and collaborate with other Pro members.",
                                color: Color(red: 1.0, green: 0.5, blue: 0.0)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
            .background(Color.white)
        }
        
        private func startGeneration() {
        guard !prompt.isEmpty else { return }
        
        let duration: TimeInterval
        switch selectedDuration {
        case "30 sec": duration = 30
        case "1 min": duration = 60
        case "2 min": duration = 120
        case "3 min": duration = 180
        default: duration = 30
        }
        
        let quality: Track.AudioQuality = selectedQuality == "HQ" ? .hq : .standard
        
        let request = GenerationRequest(
            prompt: prompt,
            genre: "Auto-detect",
            mood: selectedMood,
            duration: duration,
            quality: quality,
            instruments: selectedInstrument != nil ? [selectedInstrument!] : []
        )
        
        appState.startGeneration(request)
        showGenerationView = true
    }
}


struct ProTag: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(color)
            
            Text(text)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct GenreTag: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                Text(text)
                    .font(.system(size: 13))
            }
            .foregroundColor(.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(white: 0.8), lineWidth: 1)
            )
        }
    }
}

struct QuickActionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let gradient: [Color]
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: gradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
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

struct CreationRow: View {
    let track: Track
    let onTap: () -> Void
    
    var gradientColors: [Color] {
        track.gradientColors.compactMap { colorString in
            let components = colorString.split(separator: ",")
            if components.count == 3,
               let r = Double(components[0]),
               let g = Double(components[1]),
               let b = Double(components[2]) {
                return Color(red: r, green: g, blue: b)
            }
            return nil
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                colors: gradientColors.isEmpty ? [Color(red: 0.6, green: 0.2, blue: 1.0), Color(red: 1.0, green: 0.4, blue: 0.6)] : gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: track.icon)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
                
                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.yellow)
                    .offset(x: 4, y: -4)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(track.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(track.timeAgo)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "headphones")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.6))
                        Text(track.quality == .hq ? "HQ Audio" : "Standard")
                            .font(.system(size: 11))
                            .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.6))
                    }
                    
                    Text(track.durationString)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(red: 1.0, green: 0.5, blue: 0.0))
                        .cornerRadius(8)
                }
            }
            
            Spacer()
            
            Button(action: onTap) {
                ZStack {
                    Circle()
                        .fill(Color(red: 0.6, green: 0.2, blue: 1.0))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(white: 0.8), lineWidth: 1)
        )
    }
}

struct HomeProFeatureRow: View {
    let icon: String
    let text: String
    let detail: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(detail)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

struct TemplateCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(color.opacity(0.2))
                        .frame(height: 80)
                    
                    Image(systemName: icon)
                        .font(.system(size: 32))
                        .foregroundColor(color)
                }
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Button(action: {}) {
                    Text("Try Template")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(color)
                        .cornerRadius(8)
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

struct TipCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
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


#Preview {
    HomeView()
}

