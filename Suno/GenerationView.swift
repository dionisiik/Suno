//
//  GenerationView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct GenerationView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @State private var timer: Timer?
    
    var progress: Double {
        appState.generationStatus.progress
    }
    
    var body: some View {
        NavigationView {
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
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    
                    // Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instant Priority Generation")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Your music is being created with priority processing.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Generation Status
                    VStack(spacing: 16) {
                    // Status Card
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(red: 1.0, green: 0.9, blue: 0.95), Color(red: 1.0, green: 0.85, blue: 0.9)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: appState.generationStatus == .completed ? "checkmark.circle.fill" : "wand.and.stars")
                                .font(.system(size: 28))
                                .foregroundColor(appState.generationStatus == .completed ? .green : Color(red: 1.0, green: 0.4, blue: 0.6))
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(appState.generationStatus.description)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            
                            ProgressView(value: progress)
                                .tint(Color(red: 1.0, green: 0.5, blue: 0.0))
                        }
                        
                        Spacer()
                        
                        Text("\(Int(progress * 100))%")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(red: 1.0, green: 0.5, blue: 0.0))
                    }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(white: 0.8), lineWidth: 1)
                        )
                        
                        // Priority Queue Active
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: "rocket.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Priority Queue Active")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Text("Your creation is being processed instantly with Pro benefits.")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
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
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Your Prompt
                    if let request = appState.generationRequest {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Your Prompt")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text(request.prompt)
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 8) {
                                    if let mood = request.mood {
                                        Tag(text: mood, color: Color(red: 0.6, green: 0.2, blue: 1.0))
                                    }
                                    Tag(text: request.genre, color: Color(red: 1.0, green: 0.5, blue: 0.0))
                                    Tag(text: formatDuration(request.duration), color: Color(red: 0.2, green: 0.8, blue: 0.6))
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
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                    
                    // Active Pro Benefits
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Active Pro Benefits")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            ProBenefitRow(
                                icon: "bolt.fill",
                                text: "Instant Processing",
                                detail: "No queue wait time",
                                color: Color(red: 1.0, green: 0.5, blue: 0.0)
                            )
                            
                            ProBenefitRow(
                                icon: "headphones",
                                text: "HQ Audio Quality",
                                detail: "Studio-grade output",
                                color: Color(red: 1.0, green: 0.4, blue: 0.6)
                            )
                            
                            ProBenefitRow(
                                icon: "questionmark.circle.fill",
                                text: "No Watermarks",
                                detail: "Clean, professional export",
                                color: .green
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Generation Process
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Generation Process")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            ProcessStep(
                                icon: appState.generationStatus.progress >= 0.25 ? "checkmark.circle.fill" : "circle",
                                text: "Analyzing Prompt",
                                detail: "Understanding your creative vision",
                                isComplete: appState.generationStatus.progress >= 0.25,
                                isLoading: false
                            )
                            
                            ProcessStep(
                                icon: appState.generationStatus.progress >= 0.5 ? "checkmark.circle.fill" : "circle",
                                text: "Composing Music",
                                detail: "AI is creating your melody",
                                isComplete: appState.generationStatus.progress >= 0.5,
                                isLoading: false
                            )
                            
                            ProcessStep(
                                icon: appState.generationStatus.progress >= 0.75 ? "checkmark.circle.fill" : "circle.fill",
                                text: "Rendering HQ Audio",
                                detail: "Finalizing studio-quality output",
                                isComplete: appState.generationStatus.progress >= 0.75,
                                isLoading: appState.generationStatus == .rendering
                            )
                            
                            ProcessStep(
                                icon: appState.generationStatus.progress >= 0.9 ? "checkmark.circle.fill" : "circle",
                                text: "Generating Cover Art",
                                detail: "Creating visual representation",
                                isComplete: appState.generationStatus.progress >= 0.9,
                                isLoading: appState.generationStatus == .generatingArt
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Output Specifications
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Output Specifications")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            SpecCard(
                                icon: "chart.bar.fill",
                                text: "320 kbps",
                                title: "Quality",
                                gradient: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)]
                            )
                            
                            SpecCard(
                                icon: "doc.text.fill",
                                text: "MP3/WAV",
                                title: "Format",
                                gradient: [Color(red: 0.2, green: 0.6, blue: 1.0), Color(red: 0.2, green: 0.8, blue: 0.6)]
                            )
                            
                            SpecCard(
                                icon: "clock.fill",
                                text: "1:00 min",
                                title: "Duration",
                                gradient: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 1.0, green: 0.4, blue: 0.6)]
                            )
                            
                            SpecCard(
                                icon: "checkmark.shield.fill",
                                text: "None",
                                title: "Watermark",
                                gradient: [Color.green, Color(red: 0.2, green: 0.8, blue: 0.6)]
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // AI Insights
                    VStack(alignment: .leading, spacing: 12) {
                        Text("AI Insights")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "brain.head.profile")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color(red: 0.6, green: 0.2, blue: 1.0))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Understanding your creative intent")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                InsightRow(text: "Detected mood: Peaceful & Relaxing")
                                InsightRow(text: "Primary instrument: Piano")
                                InsightRow(text: "Ambient elements: Rain sounds")
                                InsightRow(text: "Use case: Study & Focus")
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
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Time Saved
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "clock.fill")
                                .font(.system(size: 24))
                                .foregroundColor(Color(red: 1.0, green: 0.5, blue: 0.0))
                            
                            Text("Time Saved vs Free Tier")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: {}) {
                                Text("Free Queue ~45s")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                                    .cornerRadius(12)
                            }
                            
                            Button(action: {}) {
                                Text("Pro Speed ~3s")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(12)
                            }
                        }
                        
                        HStack(spacing: 4) {
                            Text("You're saving 42 seconds!")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text("✨")
                                .font(.system(size: 14))
                        }
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color(red: 1.0, green: 0.9, blue: 0.8), Color(red: 0.9, green: 1.0, blue: 0.9)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Unlimited Generations
                    HStack {
                        Image(systemName: "infinity")
                            .font(.system(size: 32))
                            .foregroundColor(.green)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Unlimited Generations")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text("Create as much as you want with Pro. No daily limits!")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(white: 0.8), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // What's Next?
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What's Next?")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            NextStepCard(
                                icon: "play.circle.fill",
                                text: "Listen & Preview",
                                detail: "High-quality playback ready",
                                color: Color(red: 0.2, green: 0.6, blue: 1.0)
                            )
                            
                            NextStepCard(
                                icon: "arrow.down.circle.fill",
                                text: "Download Files",
                                detail: "MP3 & WAV formats available",
                                color: Color(red: 0.6, green: 0.2, blue: 1.0)
                            )
                            
                            NextStepCard(
                                icon: "square.and.arrow.up.fill",
                                text: "Share Creation",
                                detail: "No watermarks on exports",
                                color: Color(red: 1.0, green: 0.4, blue: 0.6)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Action Buttons
                    if appState.generationStatus == .completed {
                        Button(action: {
                            if let track = appState.currentTrack {
                                appState.playTrack(track)
                                dismiss()
                            }
                        }) {
                            HStack {
                                Image(systemName: "play.fill")
                                    .font(.system(size: 16))
                                Text("Play Track")
                                    .font(.system(size: 16, weight: .medium))
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
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    } else {
                        Button(action: {
                            appState.cancelGeneration()
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16))
                                Text("Cancel Generation")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(white: 0.9))
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                        
                        if appState.generationStatus.progress > 0.5 {
                            Text("Generation is almost complete")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .padding(.bottom, 32)
                        }
                    }
                }
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
        .onAppear {
            if appState.generationStatus == .idle {
                dismiss()
            }
        }
        .onChange(of: appState.generationStatus) { oldValue, newValue in
            if newValue == .completed {
                // Auto-dismiss after showing completion
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    if appState.currentTrack != nil {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        if minutes > 0 {
            return "\(minutes) min"
        } else {
            return "\(seconds) sec"
        }
    }
}

struct Tag: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color)
            .cornerRadius(12)
    }
}

struct ProBenefitRow: View {
    let icon: String
    let text: String
    let detail: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(detail)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 16))
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

struct ProcessStep: View {
    let icon: String
    let text: String
    let detail: String
    let isComplete: Bool
    var isLoading: Bool = false
    
    var body: some View {
        HStack {
            if isLoading {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 1.0, green: 0.5, blue: 0.0)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 32, height: 32)
                    
                    ProgressView()
                        .tint(.white)
                }
            } else {
                Image(systemName: icon)
                    .foregroundColor(isComplete ? .green : .gray)
                    .font(.system(size: 20))
                    .frame(width: 32)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(detail)
                    .font(.system(size: 12))
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

struct SpecCard: View {
    let icon: String
    let text: String
    let title: String
    let gradient: [Color]
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 60)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
            }
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

struct InsightRow: View {
    let text: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color(red: 0.6, green: 0.2, blue: 1.0))
                .frame(width: 6, height: 6)
            
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.black)
        }
    }
}

struct NextStepCard: View {
    let icon: String
    let text: String
    let detail: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(detail)
                    .font(.system(size: 12))
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
    GenerationView()
}

