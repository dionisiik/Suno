//
//  SunoApp.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import SwiftUI

@main
struct SunoApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isAuthenticated {
                MainTabView()
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}
