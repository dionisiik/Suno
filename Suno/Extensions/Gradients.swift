//
//  Gradients.swift
//  Suno
//
//  Shared linear gradients for reuse across the app.
//

import SwiftUI

struct AppGradients {
    // 1. Голубой градиент (#60A5FA → #06B6D4)
    static let blue: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.376, green: 0.647, blue: 0.980), // #60A5FA
            Color(red: 0.024, green: 0.714, blue: 0.831)  // #06B6D4
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // 2. Розовый (#C084FC → #EC4899)
    static let pink: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.753, green: 0.518, blue: 0.988), // #C084FC
            Color(red: 0.925, green: 0.282, blue: 0.600)  // #EC4899
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // 3. Зеленый (#4ADE80 → #14B8A6)
    static let green: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.290, green: 0.871, blue: 0.502), // #4ADE80
            Color(red: 0.078, green: 0.722, blue: 0.651)  // #14B8A6
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // 4. Краснооранжевый (#FB923C → #EF4444)
    static let redOrange: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.984, green: 0.573, blue: 0.235), // #FB923C
            Color(red: 0.937, green: 0.267, blue: 0.267)  // #EF4444
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // 5. Оранжевожелтый (#FACC15 → #F97316)
    static let orangeYellow: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.980, green: 0.800, blue: 0.082), // #FACC15
            Color(red: 0.976, green: 0.451, blue: 0.086)  // #F97316
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // 6. Синефиолетовый (#60A5FA → #6366F1)
    static let blueViolet: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.376, green: 0.647, blue: 0.980), // #60A5FA
            Color(red: 0.388, green: 0.400, blue: 0.945)  // #6366F1
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // 7. Краснорозовый (#F472B6 → #EF4444)
    static let redPink: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.957, green: 0.447, blue: 0.714), // #F472B6
            Color(red: 0.937, green: 0.267, blue: 0.267)  // #EF4444
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // 8. Фиолетовосиний (#C084FC → #3B82F6)
    static let violetBlue: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.753, green: 0.518, blue: 0.988), // #C084FC
            Color(red: 0.231, green: 0.510, blue: 0.965)  // #3B82F6
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // 9. Pro background gradient (#F3E8FF → #FCE7F3 → #FFEDD5)
    static let proBackground: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.953, green: 0.910, blue: 1.0),   // #F3E8FF
            Color(red: 0.988, green: 0.906, blue: 0.953), // #FCE7F3
            Color(red: 1.0,   green: 0.929, blue: 0.835)  // #FFEDD5
        ],
        startPoint: .leading,
        endPoint: .trailing
    )

    // 10. Градиент для play-кнопки на Home (#F472B6 → #A855F7)
    static let playHomeButtonGradient: LinearGradient = LinearGradient(
        colors: [
            Color(red: 0.957, green: 0.447, blue: 0.714), // #F472B6
            Color(red: 0.659, green: 0.333, blue: 0.969)  // #A855F7
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}


