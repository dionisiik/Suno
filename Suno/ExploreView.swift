//
//  ExploreView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                    // Header
                    HStack {
                        Text("Explore")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    
                    // Trending Now
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Trending Now")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<5) { index in
                                    TrendingCard(index: index)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    // Categories
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Categories")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            CategoryCard(
                                icon: "music.note",
                                title: "Pop",
                                color: Color(red: 1.0, green: 0.4, blue: 0.6)
                            )
                            
                            CategoryCard(
                                icon: "guitars",
                                title: "Rock",
                                color: Color(red: 1.0, green: 0.5, blue: 0.0)
                            )
                            
                            CategoryCard(
                                icon: "headphones",
                                title: "Electronic",
                                color: Color(red: 0.6, green: 0.2, blue: 1.0)
                            )
                            
                            CategoryCard(
                                icon: "piano",
                                title: "Classical",
                                color: Color(red: 0.2, green: 0.6, blue: 1.0)
                            )
                            
                            CategoryCard(
                                icon: "music.mic",
                                title: "Hip-Hop",
                                color: Color(red: 1.0, green: 0.5, blue: 0.0)
                            )
                            
                            CategoryCard(
                                icon: "music.note.list",
                                title: "Jazz",
                                color: Color(red: 0.2, green: 0.8, blue: 0.6)
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Discover
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Discover")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            DiscoverCard(
                                title: "Weekly Top Charts",
                                subtitle: "Most popular tracks this week",
                                gradient: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 1.0, green: 0.4, blue: 0.6)]
                            )
                            
                            DiscoverCard(
                                title: "New Releases",
                                subtitle: "Fresh music just added",
                                gradient: [Color(red: 0.6, green: 0.2, blue: 1.0), Color(red: 0.2, green: 0.6, blue: 1.0)]
                            )
                            
                            DiscoverCard(
                                title: "Editor's Picks",
                                subtitle: "Curated selection for you",
                                gradient: [Color(red: 0.2, green: 0.8, blue: 0.6), Color(red: 0.2, green: 0.6, blue: 1.0)]
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Popular Creators
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Popular Creators")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Text("See All")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.6))
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<5) { index in
                                    CreatorCard(index: index)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 100)
                }
                .background(Color.white)
            }
    }
}

struct TrendingCard: View {
        let index: Int
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 1.0, green: 0.4, blue: 0.6),
                                    Color(red: 0.6, green: 0.2, blue: 1.0),
                                    Color(red: 1.0, green: 0.5, blue: 0.0)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 160, height: 160)
                    
                    Image(systemName: "music.note")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Trending Track \(index + 1)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("By Creator \(index + 1)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 160)
        }
    }
    
    struct CategoryCard: View {
        let icon: String
        let title: String
        let color: Color
        
        var body: some View {
            Button(action: {}) {
                VStack(spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(color.opacity(0.2))
                            .frame(height: 100)
                        
                        Image(systemName: icon)
                            .font(.system(size: 40))
                            .foregroundColor(color)
                    }
                    
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
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
    
    struct DiscoverCard: View {
        let title: String
        let subtitle: String
        let gradient: [Color]
        
        var body: some View {
            Button(action: {}) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(title)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(subtitle)
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }
                .padding(20)
                .background(
                    LinearGradient(
                        colors: gradient,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
            }
        }
    }
    
    struct CreatorCard: View {
        let index: Int
        
        var body: some View {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 1.0, green: 0.4, blue: 0.6),
                                    Color(red: 0.6, green: 0.2, blue: 1.0)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)
                    
                    Text("C\(index + 1)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("Creator \(index + 1)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("\(100 + index * 50) tracks")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .frame(width: 100)
        }
}

#Preview {
    ExploreView()
}
