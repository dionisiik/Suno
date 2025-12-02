//
//  HomeView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection
                createMusicSection
                proMemberSection
                promptSection
                advancedOptionsSection
                generateButtonSection
                quickActionsSection
                recentCreationsSection
                proExclusiveFeaturesSection
                trendingTemplatesSection
                proTipsSection
            }
            .background(Color.white)
        }
    }
    
    // MARK: - Sections
    
    private var headerSection: some View {
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
    }
    
    private var createMusicSection: some View {
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
    }
    
    private var proMemberSection: some View {
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
    }
    
    private var promptSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What do you want to create?")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            TextEditor(text: $viewModel.prompt)
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
                        if viewModel.prompt.isEmpty {
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
    }
    
    private var advancedOptionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: { viewModel.advancedOptionsExpanded.toggle() }) {
                HStack {
                    Text("Advanced Options")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: viewModel.advancedOptionsExpanded ? "chevron.down" : "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            
            if viewModel.advancedOptionsExpanded {
                genreDropdown
                moodSelection
                durationSelection
                audioQualitySelection
                instrumentsSelection
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
    }
    
    private var genreDropdown: some View {
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
    }
    
    private var moodSelection: some View {
        MoodSelectionView(selectedMood: $viewModel.selectedMood)
    }
    
    private var durationSelection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Duration")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            HStack(spacing: 12) {
                ForEach(["30 sec", "1 min", "2 min", "3 min"], id: \.self) { duration in
                    Button(action: { viewModel.selectedDuration = duration }) {
                        Text(duration)
                            .font(.system(size: 13))
                            .foregroundColor(viewModel.selectedDuration == duration ? Color(red: 1.0, green: 0.4, blue: 0.6) : .black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(viewModel.selectedDuration == duration ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.selectedDuration == duration ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: viewModel.selectedDuration == duration ? 2 : 1)
                            )
                    }
                }
            }
        }
    }
    
    private var audioQualitySelection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Audio Quality")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            HStack(spacing: 12) {
                Button(action: { viewModel.selectedQuality = "Standard" }) {
                    Text("Standard")
                        .font(.system(size: 13))
                        .foregroundColor(viewModel.selectedQuality == "Standard" ? Color(red: 1.0, green: 0.4, blue: 0.6) : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(viewModel.selectedQuality == "Standard" ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.selectedQuality == "Standard" ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: viewModel.selectedQuality == "Standard" ? 2 : 1)
                        )
                }
                
                Button(action: { viewModel.selectedQuality = "HQ" }) {
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.yellow)
                        Text("HQ")
                            .font(.system(size: 13))
                    }
                    .foregroundColor(viewModel.selectedQuality == "HQ" ? Color(red: 1.0, green: 0.4, blue: 0.6) : .black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(viewModel.selectedQuality == "HQ" ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.selectedQuality == "HQ" ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: viewModel.selectedQuality == "HQ" ? 2 : 1)
                    )
                }
            }
        }
    }
    
    private var instrumentsSelection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Instruments (Optional)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(["🎹 Piano", "🎸 Guitar", "🥁 Drums", "🎻 Strings", "🎤 Vocals", "🎶 Synth"], id: \.self) { instrument in
                    Button(action: { viewModel.selectedInstrument = viewModel.selectedInstrument == instrument ? nil : instrument }) {
                        Text(instrument)
                            .font(.system(size: 13))
                            .foregroundColor(viewModel.selectedInstrument == instrument ? Color(red: 1.0, green: 0.4, blue: 0.6) : .black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(viewModel.selectedInstrument == instrument ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.selectedInstrument == instrument ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8), lineWidth: viewModel.selectedInstrument == instrument ? 2 : 1)
                            )
                    }
                }
            }
        }
    }
    
    private var generateButtonSection: some View {
        VStack(spacing: 8) {
            Button(action: {
                viewModel.startGeneration(appState: appState)
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
            .disabled(viewModel.prompt.isEmpty)
            .opacity(viewModel.prompt.isEmpty ? 0.6 : 1.0)
            
            Text("Priority processing • No queue • No watermarks")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 32)
        .sheet(isPresented: $viewModel.showGenerationView) {
            GenerationView()
                .environmentObject(appState)
        }
    }
    
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Actions")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 12
            ) {
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
    }
    
    private var recentCreationsSection: some View {
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
    }
    
    private var proExclusiveFeaturesSection: some View {
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
    }
    
    private var trendingTemplatesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
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
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                TemplateCard(
                    TemplateIconImageName: "cloudWhite",
                    title: "Dream Pop",
                    subtitle: "Ethereal & atmospheric",
                    color: Color(red: 0.4, green: 0.8, blue: 1.0)
                )
                
                TemplateCard(
                    TemplateIconImageName: "likeWhite",
                    title: "Romantic",
                    subtitle: "Soft & emotional",
                    color: Color(red: 1.0, green: 0.4, blue: 0.6)
                )
                
                TemplateCard(
                    TemplateIconImageName: "sunWhite",
                    title: "Summer Vibes",
                    subtitle: "Upbeat & tropical",
                    color: Color(red: 1.0, green: 0.5, blue: 0.0)
                )
                
                TemplateCard(
                    TemplateIconImageName: "LeafWhite",
                    title: "Nature Sounds",
                    subtitle: "Peaceful & organic",
                    color: .green
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 32)
    }
    
    private var proTipsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pro Tips for Better Results")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            VStack(spacing: 12) {
                TipCard(
                    TipIconImageName: "bulbWhite",
                    title: "Be Specific",
                    description: "Include instruments, tempo, and mood for better results. Example: Upbeat acoustic guitar with soft drums, 126 BPM.",
                    color: Color(red: 0.2, green: 0.6, blue: 1.0)
                )
                
                TipCard(
                    TipIconImageName: "palleteWhite",
                    title: "Experiment with Genres",
                    description: "Try blending different genres to discover unique sounds. Mix classical with electronic or jazz with hip-hop!",
                    color: Color(red: 0.6, green: 0.2, blue: 1.0)
                )
                
                TipCard(
                    TipIconImageName: "magicStickWithStarsWhite",
                    title: "Use Advanced Controls",
                    description: "Take advantage of HQ audio settings and custom duration options for professional-quality output.",
                    color: .green
                )
                
                TipCard(
                    TipIconImageName: "shareWhite",
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

#Preview {
    HomeView()
        .environmentObject(AppState())
}

