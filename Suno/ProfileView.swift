//
//  ProfileView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Profile")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "gearshape")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                    
                    // Profile Header
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color(red: 1.0, green: 0.4, blue: 0.6), Color(red: 0.6, green: 0.2, blue: 1.0)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 100, height: 100)
                            
                            Text("S")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Text(appState.user.name)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text(appState.user.email)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        // Pro Badge
                        if appState.user.isPro {
                            HStack(spacing: 6) {
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 12))
                                Text("Pro Member")
                                    .font(.system(size: 14, weight: .semibold))
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
                    .padding(.bottom, 32)
                    
                    // Stats
                    HStack(spacing: 20) {
                        StatCard(number: "\(appState.user.totalTracksCreated)", label: "Tracks")
                        StatCard(number: formatDuration(appState.user.totalDuration), label: "Total Time")
                        StatCard(number: "\(appState.user.dayStreak)", label: "Day Streak")
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Menu Items
                    VStack(spacing: 0) {
                        MenuRow(icon: "music.note.list", title: "My Creations", color: Color(red: 1.0, green: 0.4, blue: 0.6))
                        MenuRow(icon: "heart.fill", title: "Favorites", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                        MenuRow(icon: "arrow.down.circle.fill", title: "Downloads", color: Color(red: 0.2, green: 0.6, blue: 1.0))
                        MenuRow(icon: "crown.fill", title: "Subscription", color: Color(red: 0.6, green: 0.2, blue: 1.0))
                        MenuRow(icon: "bell.fill", title: "Notifications", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                        MenuRow(icon: "questionmark.circle.fill", title: "Help & Support", color: Color(red: 0.2, green: 0.8, blue: 0.6))
                        MenuRow(icon: "doc.text.fill", title: "Terms of Service", color: .gray)
                        MenuRow(icon: "lock.shield.fill", title: "Privacy Policy", color: .gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                    
                    // Sign Out
                    Button(action: {}) {
                        Text("Sign Out")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
                .background(Color.white)
            }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}

struct StatCard: View {
    let number: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(number)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(white: 0.95))
        .cornerRadius(16)
    }
}

struct MenuRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
        }
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(white: 0.9)),
            alignment: .bottom
        )
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
