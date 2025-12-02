//
//  HomeFreeView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI
import Foundation

struct HomeFreeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = HomeViewModel()
    
    private var attributedDescription: AttributedString {
        let text = "Transform your ideas into stunning music with AI. Unlimited generations at your fingertips!"
        var attributedString = AttributedString(text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 26.0 / 16.0  // line height 26 для font size 16
        paragraphStyle.alignment = .center
        
        attributedString.font = .system(size: 16)
        attributedString.foregroundColor = Color(red: 0.294, green: 0.333, blue: 0.388) // #4B5563
        
        let range = attributedString.startIndex..<attributedString.endIndex
        attributedString[range].paragraphStyle = paragraphStyle
        
        return attributedString
    }
    
    var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                headerSection
                createMusicSection
                promptSection
                advancedOptionsSection
                dailyCreditsSection
                generateButtonSection
                quickActionsSection
                recentCreationsSection
                trendingTemplatesSection
                creativeJourneySection
                proTipsSection
            }
            .background(Color.white)
        }
    }
    
    // MARK: - Sections
    
    private var headerSection: some View {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Good Morning")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
            HStack(alignment: .center) {
                            HStack(spacing: 4) {
                    Text("Hey, \(appState.user.name)!")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text("👋")
                                    .font(.system(size: 28))
                        }
                        
                        Spacer()
                        
                HStack(spacing: 12) {
                        Button(action: {}) {
                            HStack(spacing: 6) {
                            Image("proCrownWhite")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                Text("Upgrade")
                                    .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.white)
                            }
                        .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        .background(AppGradients.redOrange)
                        .cornerRadius(20)
                    }
                    
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.953, green: 0.957, blue: 0.965)) // #F3F4F6
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Circle()
                                        .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
                                )
                            
                            Image("gearGray")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
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
                    .fill(AppGradients.orangePinkPurple)
                                .frame(width: 100, height: 100)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                
                Image("magicStickWithStarsWhiteBig")
                    .resizable()
                    .interpolation(.high)
                    .antialiased(false)
                    .scaledToFit()
                    .frame(width: 39, height: 36)
                    .foregroundColor(.white)
                        }
                        
                        Text("Create Your Music")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        
            Text(attributedDescription)
                            .multilineTextAlignment(.center)
                .lineLimit(3)
                            .padding(.horizontal, 20)
                    }
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
                    GenreTag(icon: "lightningYellow", text: "Energetic Pop", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                    GenreTag(icon: "moonSYSBlue", text: "Chill Lofi", color: Color(red: 0.2, green: 0.6, blue: 1.0))
                    GenreTag(icon: "guitarColor", text: "Acoustic", color: Color(red: 0.6, green: 0.4, blue: 0.2))
                    GenreTag(icon: "drumColor", text: "Epic", color: .red)
                            }
                            .padding(.horizontal, 4)
                        }
                    }
        .padding(20)
        .background(Color(red: 0.976, green: 0.980, blue: 0.984)) // #F9FAFB
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
        )
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
        .padding(20)
        .background(Color(red: 0.976, green: 0.980, blue: 0.984)) // #F9FAFB
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
        )
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
    
    private var dailyCreditsSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                // Иконка с градиентом
                ZStack {
                    Circle()
                        .fill(AppGradients.orangePinkPurple)
                        .frame(width: 32, height: 32)
                    
                    Image("fireWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 14)
                        .foregroundColor(.white)
                }
                
                // Текстовая информация
                VStack(alignment: .leading, spacing: 4) {
                    Text("Daily Credits")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 4) {
                        Text("2/5")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("remaining")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                // Кнопка Get More
                Button(action: {}) {
                    Text("Get More")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(red: 0.859, green: 0.153, blue: 0.467)) // #DB2777
                }
            }
            
            // Прогресс-бар
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Фон прогресс-бара
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 4)
                    
                    // Заполненная часть
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.859, green: 0.153, blue: 0.467)) // #DB2777
                        .frame(width: geometry.size.width * 0.4, height: 4) // 2/5 = 40%
                }
            }
            .frame(height: 4)
        }
        .padding(16)
        .background(AppGradients.dailyCreditsBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.996, green: 0.843, blue: 0.667), lineWidth: 1) // #FED7AA
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
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
                .background(AppGradients.orangePinkPurple)
                            .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
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
                    QuickActionIconImageName: "microphoneWhite",
                    title: "Voice Input",
                    subtitle: "Speak your idea",
                    gradient: AppGradients.blue
                )
                
                QuickActionCard(
                    QuickActionIconImageName: "magicStickNoStarsWhite",
                    title: "Surprise Me",
                    subtitle: "Random creation",
                    gradient: AppGradients.pink
                )
                
                QuickActionCard(
                    QuickActionIconImageName: "remixWhite",
                    title: "Remix",
                    subtitle: "Edit previous",
                    gradient: AppGradients.orangeYellow
                )
                
                QuickActionCard(
                    QuickActionIconImageName: "templatesWhite",
                    title: "Templates",
                    subtitle: "Browse presets",
                    gradient: AppGradients.green
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
                ForEach(Array(appState.tracks.prefix(3))) { track in
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
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 4),
                    GridItem(.flexible(), spacing: 4)
                ],
                spacing: 8
            ) {
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
    
    private var creativeJourneySection: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Your Creative Journey")
                .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 12) {
                // Первая ячейка - Songs Created
                VStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(AppGradients.blue)
                            .frame(width: 64, height: 64)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        Image("noteWhite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    
                    Text("12")
                        .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                    
                    Text("Songs Created")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                // Вторая ячейка - Total Duration
                VStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(AppGradients.redOrange)
                            .frame(width: 64, height: 64)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "clock.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    
                    Text("24m")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Total Duration")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                // Третья ячейка - Day Streak
                VStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(AppGradients.pink)
                            .frame(width: 64, height: 64)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        Image("fireWhite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    
                    Text("5")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Day Streak")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            }
        }
        .padding(20)
        .background(Color(red: 0.976, green: 0.980, blue: 0.984)) // #F9FAFB
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.953, green: 0.957, blue: 0.965), lineWidth: 1) // #F3F4F6
        )
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
    HomeFreeView()
        .environmentObject(AppState())
}
