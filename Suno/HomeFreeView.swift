//
//  HomeFreeView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct HomeFreeView: View {
    @State private var prompt = ""
    @State private var selectedDuration = "30 sec"
    @State private var selectedMood: String? = nil
    @State private var advancedOptionsExpanded = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Good Morning")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 4) {
                                Text("Hey, Sarah!")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text("👋")
                                    .font(.system(size: 28))
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            HStack(spacing: 6) {
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 12))
                                Text("Upgrade")
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
                    .padding(.bottom, 24)
                    
                    // Create Your Music Section
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(red: 0.6, green: 0.2, blue: 1.0), Color(red: 1.0, green: 0.4, blue: 0.6)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: "music.note")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                        }
                        
                        Text("Create Your Music")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Transform your ideas into stunning music with AI. Describe what you want to hear!")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 32)
                    
                    // What do you want to create?
                    VStack(alignment: .leading, spacing: 16) {
                        Text("What do you want to create?")
                            .font(.system(size: 18, weight: .bold))
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
                                                Text("E.g., A peaceful piano melody with soft rain sounds, perfect for studying and relaxation")
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
                                    ForEach(["Happy", "Calm", "Energetic", "Sad", "Epic", "Dark"], id: \.self) { mood in
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
                                    ForEach(["30 sec", "1 min", "2 min"], id: \.self) { duration in
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
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Daily Credits
                    HStack {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "music.note")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Daily Credits")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Text("2/5 remaining")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("Get More")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(red: 0.6, green: 0.2, blue: 1.0))
                        }
                    }
                    .padding()
                    .background(Color(white: 0.95))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                    
                    // Generate Button
                    VStack(spacing: 8) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 18))
                                Text("Generate Music")
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
                        
                        Text("By generating, you agree to our Terms of Service")
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
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
                            CreationRowFree(
                                icon: "headphones",
                                title: "Chill Lofi Beats",
                                timeAgo: "2 hours ago",
                                quality: "Standard",
                                duration: "30s",
                                gradient: [Color(red: 0.6, green: 0.2, blue: 1.0), Color(red: 1.0, green: 0.4, blue: 0.6)]
                            )
                            
                            CreationRowFree(
                                icon: "guitars",
                                title: "Acoustic Sunrise",
                                timeAgo: "Yesterday",
                                quality: "Standard",
                                duration: "1m",
                                gradient: [Color.green, Color(red: 0.2, green: 0.8, blue: 0.8)]
                            )
                            
                            CreationRowFree(
                                icon: "drum.fill",
                                title: "Epic Battle Theme",
                                timeAgo: "2 days ago",
                                quality: "Standard",
                                duration: "2m",
                                gradient: [Color.red, Color(red: 1.0, green: 0.4, blue: 0.6)]
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Why Go Pro?
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Why Go Pro?")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ProBenefitCard(
                                icon: "bolt.fill",
                                title: "Skip Queues",
                                subtitle: "Instant generation",
                                color: Color(red: 1.0, green: 0.4, blue: 0.6)
                            )
                            
                            ProBenefitCard(
                                icon: "questionmark.circle.fill",
                                title: "No Watermarks",
                                subtitle: "Clean exports",
                                color: Color(red: 0.6, green: 0.2, blue: 1.0)
                            )
                            
                            ProBenefitCard(
                                icon: "headphones",
                                title: "HQ Audio",
                                subtitle: "Studio quality",
                                color: Color(red: 1.0, green: 0.4, blue: 0.6)
                            )
                            
                            ProBenefitCard(
                                icon: "infinity",
                                title: "Unlimited",
                                subtitle: "Create freely",
                                color: .green
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // User Testimonial
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color(white: 0.9))
                                .frame(width: 60, height: 60)
                            
                            Text("ER")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                        }
                        
                        Text("Emma Rodriguez")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        HStack(spacing: 2) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                        Text("Going Pro was the best decision! The audio quality is incredible and I can create as much as I want. Perfect for my content creation.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(24)
                    .background(Color(red: 1.0, green: 0.9, blue: 0.95))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Your Creative Journey
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your Creative Journey")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        HStack(spacing: 16) {
                            JourneyCard(
                                icon: "music.note",
                                number: "12",
                                label: "Songs Created",
                                gradient: [Color(red: 0.2, green: 0.6, blue: 1.0), Color.green]
                            )
                            
                            JourneyCard(
                                icon: "clock.fill",
                                number: "24m",
                                label: "Total Duration",
                                gradient: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 1.0, green: 0.4, blue: 0.6)]
                            )
                            
                            JourneyCard(
                                icon: "flame.fill",
                                number: "5",
                                label: "Day Streak",
                                gradient: [Color(red: 0.6, green: 0.2, blue: 1.0), Color(red: 1.0, green: 0.4, blue: 0.6)]
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Pro Tips
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Pro Tips")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            TipCardFree(
                                icon: "lightbulb.fill",
                                title: "Be Specific",
                                description: "Include instruments, tempo, and mood for better results",
                                color: Color(red: 0.2, green: 0.6, blue: 1.0)
                            )
                            
                            TipCardFree(
                                icon: "puzzlepiece.fill",
                                title: "Experiment",
                                description: "Try different genres and moods to discover unique sounds",
                                color: Color(red: 0.6, green: 0.2, blue: 1.0)
                            )
                            
                            TipCardFree(
                                icon: "square.and.arrow.up.fill",
                                title: "Share & Inspire",
                                description: "Share your creations with the community for feedback",
                                color: .green
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Unlock Full Potential CTA
                    VStack(spacing: 20) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                        
                        Text("Unlock Full Potential")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Get unlimited generations, HQ audio, and instant creation")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                        
                        Button(action: {}) {
                            Text("Try Pro Free for 3 Days")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                        }
                        
                        Text("Then $9.99/month. Cancel anytime.")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(32)
                    .background(
                        LinearGradient(
                            colors: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 0.6, green: 0.2, blue: 1.0)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(24)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}

struct CreationRowFree: View {
    let icon: String
    let title: String
    let timeAgo: String
    let quality: String
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
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(timeAgo)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    Text(quality)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    
                    Text(duration)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(red: 1.0, green: 0.5, blue: 0.0))
                        .cornerRadius(8)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                ZStack {
                    Circle()
                        .fill(Color(white: 0.8))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "play.fill")
                        .foregroundColor(.gray)
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

struct ProBenefitCard: View {
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

struct JourneyCard: View {
    let icon: String
    let number: String
    let label: String
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
            
            Text(number)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
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

struct TipCardFree: View {
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
    HomeFreeView()
}

