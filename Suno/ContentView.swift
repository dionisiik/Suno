//
//  ContentView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Suno App Screens")
                        .font(.system(size: 28, weight: .bold))
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 16) {
                        // Login Screens
                        SectionHeader(title: "Login & Sign Up")
                        
                        NavigationLink(destination: LoginView()) {
                            ScreenRow(icon: "person.circle", title: "Login Screen", color: .blue)
                        }
                        
                        NavigationLink(destination: LoginWithProTrialView()) {
                            ScreenRow(icon: "person.circle.fill", title: "Login with Pro Trial", color: .purple)
                        }
                        
                        NavigationLink(destination: SubscriptionPlanView()) {
                            ScreenRow(icon: "crown.fill", title: "Subscription Plan", color: .orange)
                        }
                        
                        // Home Screens
                        SectionHeader(title: "Home Screens")
                        
                        NavigationLink(destination: HomeView()) {
                            ScreenRow(icon: "house.fill", title: "Home (Pro)", color: Color(red: 1.0, green: 0.4, blue: 0.6))
                        }
                        
                        NavigationLink(destination: HomeFreeView()) {
                            ScreenRow(icon: "house", title: "Home (Free)", color: .gray)
                        }
                        
                        // Generation
                        SectionHeader(title: "Generation")
                        
                        NavigationLink(destination: GenerationView()) {
                            ScreenRow(icon: "sparkles", title: "Generation Process", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                        }
                        
                        // Now Playing
                        SectionHeader(title: "Music Player")
                        
                        NavigationLink(destination: NowPlayingView()) {
                            ScreenRow(icon: "play.circle.fill", title: "Now Playing (Free)", color: .blue)
                        }
                        
                        NavigationLink(destination: NowPlayingProView()) {
                            ScreenRow(icon: "play.circle", title: "Now Playing (Pro)", color: Color(red: 0.6, green: 0.2, blue: 1.0))
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .background(Color.white)
            .navigationBarHidden(true)
        }
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.top, 8)
    }
}

struct ScreenRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(white: 0.95))
        .cornerRadius(12)
    }
}

#Preview {
    ContentView()
}
