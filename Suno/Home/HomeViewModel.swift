//
//  HomeViewModel.swift
//  Suno
//
//  Created by Edward on 28.11.2025.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    // MARK: - Input
    @Published var prompt: String = ""
    @Published var selectedDuration: String = "30 sec"
    @Published var selectedQuality: String = "HQ"
    @Published var selectedMood: String? = nil
    @Published var selectedInstrument: String? = nil
    @Published var advancedOptionsExpanded: Bool = false
    
    // MARK: - Navigation
    @Published var showGenerationView: Bool = false
    
    // MARK: - Actions
    func startGeneration(appState: AppState) {
        guard !prompt.isEmpty else { return }
        
        let duration: TimeInterval
        switch selectedDuration {
        case "30 sec": duration = 30
        case "1 min": duration = 60
        case "2 min": duration = 120
        case "3 min": duration = 180
        default: duration = 30
        }
        
        let quality: Track.AudioQuality = selectedQuality == "HQ" ? .hq : .standard
        
        let request = GenerationRequest(
            prompt: prompt,
            genre: "Auto-detect",
            mood: selectedMood,
            duration: duration,
            quality: quality,
            instruments: selectedInstrument != nil ? [selectedInstrument!] : []
        )
        
        appState.startGeneration(request)
        showGenerationView = true
    }
}

