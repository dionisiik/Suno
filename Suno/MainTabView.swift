//
//  MainTabView.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var appState = AppState()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .environmentObject(appState)
                    .tag(0)
                
                ExploreView()
                    .environmentObject(appState)
                    .tag(1)
                
                LibraryView()
                    .environmentObject(appState)
                    .tag(2)
                
                ProfileView()
                    .environmentObject(appState)
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                BottomNavBar(selectedTab: selectedTab) {
                    selectedTab = $0
                    appState.selectedTab = $0
                }
            }
        }
    }
}

struct BottomNavBar: View {
    let selectedTab: Int
    let onTabSelected: (Int) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            NavBarItem(
                icon: "house.fill",
                label: "Home",
                isSelected: selectedTab == 0,
                action: { onTabSelected(0) }
            )
            
            NavBarItem(
                icon: "safari",
                label: "Explore",
                isSelected: selectedTab == 1,
                action: { onTabSelected(1) }
            )
            
            NavBarItem(
                icon: "folder.fill",
                label: "Library",
                isSelected: selectedTab == 2,
                action: { onTabSelected(2) }
            )
            
            NavBarItem(
                icon: "person.fill",
                label: "Profile",
                isSelected: selectedTab == 3,
                action: { onTabSelected(3) }
            )
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .padding(.bottom, 8)
        .background(Color(white: 0.95))
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
    }
}

struct NavBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                if isSelected {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 1.0, green: 0.5, blue: 0.0), Color(red: 1.0, green: 0.4, blue: 0.6)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: icon)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                } else {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                        .frame(width: 44, height: 44)
                }
                
                Text(label)
                    .font(.system(size: 10))
                    .foregroundColor(isSelected ? Color(red: 1.0, green: 0.4, blue: 0.6) : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    MainTabView()
}

