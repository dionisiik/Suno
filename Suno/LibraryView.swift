//
//  LibraryView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var selectedTrack: Track?
    
    var filteredTracks: [Track] {
        appState.filteredTracks(filter: selectedFilter)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Library")
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
                .padding(.bottom, 24)
                
                // Filter Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(["All", "Recent", "Favorites", "Downloads"], id: \.self) { filter in
                            Button(action: { selectedFilter = filter }) {
                                Text(filter)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedFilter == filter ? .white : .black)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(
                                        selectedFilter == filter ?
                                        LinearGradient(
                                            colors: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 1.0, green: 0.4, blue: 0.6)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ) :
                                        LinearGradient(colors: [Color(white: 0.95)], startPoint: .leading, endPoint: .trailing)
                                    )
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 24)
                
                // Tracks List
                VStack(spacing: 12) {
                    ForEach(filteredTracks) { track in
                        LibraryTrackRow(
                            track: track,
                            onTap: {
                                selectedTrack = track
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
                .sheet(item: $selectedTrack) { track in
                    if appState.user.isPro {
                        NowPlayingProView()
                            .environmentObject(appState)
                    } else {
                        NowPlayingView()
                            .environmentObject(appState)
                    }
                }
                }
                .background(Color.white)
            }
    }
}

struct LibraryTrackRow: View {
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
        Button(action: onTap) {
            HStack(spacing: 12) {
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
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(track.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(track.timeAgo)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(track.durationString)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        onTap()
                    }) {
                        Image(systemName: "play.fill")
                            .foregroundColor(Color(red: 0.6, green: 0.2, blue: 1.0))
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
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LibraryView()
}

