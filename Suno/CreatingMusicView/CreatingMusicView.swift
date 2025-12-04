//
//  CreatingMusicView.swift
//  Suno
//
//  Created by Дионисий Коневиченко on 03.12.2025.
//

import SwiftUI
import AVKit

enum GenerationStep: Int {
    case analyzing = 1
    case composing = 2
    case finalizing = 3
}

struct CreatingMusicView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @State private var player: AVPlayer?
    @State private var currentStep: GenerationStep = .analyzing
    @State private var stepTimer: Timer?
    @State private var queueTimer: Timer?
    @State private var queuePosition: Int = 12
    @State private var queueTotal: Int = 45
    
    // MARK: - Computed Properties
    
    private var progress: Double {
        switch currentStep {
        case .analyzing:
            return 0.33
        case .composing:
            return 0.66
        case .finalizing:
            return 1.0
        }
    }
    
    private var currentStepText: String {
        switch currentStep {
        case .analyzing:
            return "Step 1 of 3"
        case .composing:
            return "Step 2 of 3"
        case .finalizing:
            return "Step 3 of 3"
        }
    }
    
    private var queueProgress: Double {
        guard queueTotal > 0 else { return 0 }
        return Double(queuePosition) / Double(queueTotal)
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            headerSection
            
            ScrollView {
                VStack(spacing: 24) {
                    animationSection
                    titleSection
                    descriptionSection
                    yourPromptSection
                    queuePositionSection
                    generationProgressSection
                    generationStepsSection
                    audioQualitySection
                    whileYouWaitSection
                }
                .padding(.bottom, 32)
            }
            
            // Закрепленная кнопка внизу
            cancelButtonSection
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            startStepTimer()
            startQueueTimer()
        }
        .onDisappear {
            stopStepTimer()
            stopQueueTimer()
        }
    }
    
    // MARK: - Sections
    
    
    private var headerSection: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text("Creating Your Music")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 24)
    }
    
    private var animationSection: some View {
        creatingAnimation
            .padding(.top, 32)
    }
    
    private var titleSection: some View {
        Text("Crafting Your Masterpiece")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.black)
    }
    
    private var descriptionSection: some View {
        Text("Our AI is composing a unique track just for you...")
            .font(.system(size: 16))
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
    }
    
    private var creatingAnimation: some View {
        Group {
            if let player = player {
                VideoPlayer(player: player)
                    .frame(width: 280, height: 280)
                    .cornerRadius(140)
                    .onAppear {
                        player.play()
                    }
            } else {
                // Fallback: показываем placeholder, если видео не найдено
                ZStack {
                    Circle()
                        .fill(AppGradients.orangePinkPurple)
                        .frame(width: 280, height: 280)
                    
                    Image(systemName: "music.note")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            setupVideoPlayer()
        }
        .onDisappear {
            player?.pause()
        }
    }
    
    private func setupVideoPlayer() {
        guard let url = Bundle.main.url(forResource: "creatingAnimation", withExtension: "mp4") else {
            return
        }
        
        let newPlayer = AVPlayer(url: url)
        player = newPlayer
        
        // Зацикливаем видео
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: newPlayer.currentItem,
            queue: .main
        ) { _ in
            newPlayer.seek(to: .zero)
            newPlayer.play()
        }
    }
    
    private var yourPromptSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Заголовок с кавычками
            HStack(spacing: 8) {
                Text("\u{201C}")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(red: 0.576, green: 0.200, blue: 0.918)) // #9333EA
                
                Text("Your Prompt")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }
            
            // Текст промпта
            if let request = appState.generationRequest {
                Text(request.prompt)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 4)
                
                // Ячейки жанров
                HStack(spacing: 8) {
                    if let mood = request.mood {
                        GenreTag(
                            icon: "moonSYSBlue",
                            text: mood,
                            color: Color(red: 0.576, green: 0.200, blue: 0.918) // #9333EA
                        )
                    }
                    
                    GenreTag(
                        icon: "noteWhite",
                        text: request.genre,
                        color: Color(red: 0.576, green: 0.200, blue: 0.918) // #9333EA
                    )
                    
                    GenreTag(
                        icon: "clock.fill",
                        text: formatDuration(request.duration),
                        color: Color(red: 0.576, green: 0.200, blue: 0.918) // #9333EA
                    )
                }
                .padding(.top, 8)
            } else {
                // Fallback для демонстрации
                Text("A peaceful piano melody with soft rain sounds, perfect for studying and relaxation")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 4)
                
                HStack(spacing: 8) {
                    GenreTag(
                        icon: "noteWhite",
                        text: "Classical",
                        color: Color(red: 0.576, green: 0.200, blue: 0.918) // #9333EA
                    )
                    
                    GenreTag(
                        icon: "moonSYSBlue",
                        text: "Calm",
                        color: Color(red: 0.576, green: 0.200, blue: 0.918) // #9333EA
                    )
                    
                    GenreTag(
                        icon: "clock.fill",
                        text: "30 sec",
                        color: Color(red: 0.576, green: 0.200, blue: 0.918) // #9333EA
                    )
                }
                .padding(.top, 8)
            }
        }
        .padding(16)
        .background(AppGradients.promptBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.914, green: 0.835, blue: 1.0), lineWidth: 1) // #E9D5FF
        )
        .padding(.horizontal, 20)
    }
    
    private var queuePositionSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                // Иконка с градиентом
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppGradients.orangePinkPurple)
                        .frame(width: 32, height: 32)
                    
                    Image("groupedPeopleWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                
                // Текстовая информация
                VStack(alignment: .leading, spacing: 4) {
                    Text("Queue Position")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("Free tier processing")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Queue position indicator
                VStack(alignment: .trailing, spacing: 2) {
                    Text("#\(queuePosition)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("of \(queueTotal)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            
            // Прогресс-бар
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Фон прогресс-бара
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.898, green: 0.906, blue: 0.922).opacity(0.3)) // #E5E7EB
                        .frame(height: 4)
                    
                    // Заполненная часть с градиентом
                    RoundedRectangle(cornerRadius: 2)
                        .fill(AppGradients.orangePinkPurple)
                        .frame(width: geometry.size.width * queueProgress, height: 4)
                        .animation(.easeInOut(duration: 0.5), value: queueProgress)
                }
            }
            .frame(height: 4)
        }
        .padding(16)
        .background(AppGradients.dailyCreditsBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.996, green: 0.843, blue: 0.667), lineWidth: 1) // #FED7AA
        )
        .padding(.horizontal, 20)
    }
    
    // MARK: - Helper Functions
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        if duration < 60 {
            return "\(Int(duration)) sec"
        } else {
            let minutes = Int(duration) / 60
            return "\(minutes) min"
        }
    }
    
    private var generationProgressSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                // Иконка с градиентом
                ZStack {
                    Circle()
                        .fill(AppGradients.orangePinkPurple)
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: "waveform")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                
                // Текстовая информация
                VStack(alignment: .leading, spacing: 4) {
                    Text("Generation Progress")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 6, height: 6)
                        
                        Text("Processing audio...")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                // Step indicator
                Text(currentStepText)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
            }
            
            // Прогресс-бар
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Фон прогресс-бара
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.898, green: 0.906, blue: 0.922).opacity(0.3)) // #E5E7EB
                        .frame(height: 4)
                    
                    // Заполненная часть с градиентом
                    RoundedRectangle(cornerRadius: 2)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.925, green: 0.282, blue: 0.600), // #EC4899
                                    Color(red: 0.576, green: 0.200, blue: 0.918)  // #9333EA
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress, height: 4)
                        .animation(.easeInOut(duration: 0.5), value: progress) // Анимация заполнения
                }
            }
            .frame(height: 4)
        }
        .padding(16)
        .background(AppGradients.dailyCreditsBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.996, green: 0.843, blue: 0.667), lineWidth: 1) // #FED7AA
        )
        .padding(.horizontal, 20)
    }
    
    private var generationStepsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Generation Steps")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
            
            VStack(spacing: 12) {
                // Step 1: Analyzing Prompt
                stepCard(for: .analyzing)
                
                // Step 2: Composing Music
                stepCard(for: .composing)
                
                // Step 3: Finalizing Audio
                stepCard(for: .finalizing)
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 8)
    }
    
    private var audioQualitySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                // Иконка
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.820, green: 0.835, blue: 0.859)) // #D1D5DB
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                
                Text("Audio Quality")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // Standard tag
                Text("Standard")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(red: 0.294, green: 0.333, blue: 0.388)) // #4B5563
                    .cornerRadius(12)
            }
            
            // Description
            Text("Your track will be generated in standard quality (128 kbps)")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            // Upgrade section
            Button(action: {}) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Upgrade for HQ Audio")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.green)
                        
                        Text("320 kbps quality")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
                )
            }
        }
        .padding(16)
        .background(Color(red: 0.976, green: 0.980, blue: 0.984)) // #F9FAFB
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
        )
        .padding(.horizontal, 20)
    }
    
    private var whileYouWaitSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("While You Wait")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
            
            VStack(spacing: 12) {
                WhileYouWaitCard(
                    icon: "bulbWhite",
                    title: "Did You Know?",
                    description: "Pro users get their tracks generated 10x faster with priority processing",
                    gradient: AppGradients.violetBlue
                )
                
                WhileYouWaitCard(
                    icon: "star.fill",
                    title: "Next Creation",
                    description: "Plan your next masterpiece while this one is being crafted",
                    gradient: AppGradients.blue
                )
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 8)
    }
    
    private var cancelButtonSection: some View {
        Button(action: { dismiss() }) {
            HStack(spacing: 8) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                Text("Cancel Generation")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color(red: 0.953, green: 0.957, blue: 0.965)) // #F3F4F6
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
            )
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 20)
        .background(Color.white)
    }
    
    private func stepCard(for step: GenerationStep) -> some View {
        let stepStatus = getStepStatus(for: step)
        
        switch step {
        case .analyzing:
            let iconName = stepStatus == .complete ? "checkmark" : (stepStatus == .inProgress ? "circle.dotted" : "clock.fill")
            return AnyView(generationStepCard(
                icon: iconName,
                iconColor: stepStatus == .complete ? Color(red: 0.133, green: 0.773, blue: 0.369) : (stepStatus == .inProgress ? nil : Color(red: 0.820, green: 0.835, blue: 0.859)),
                title: "Analyzing Prompt",
                description: "Understanding your creative vision",
                statusText: stepStatus == .complete ? "Complete" : (stepStatus == .inProgress ? "In Progress" : "Pending"),
                statusTextColor: stepStatus == .complete ? Color(red: 0.086, green: 0.639, blue: 0.290) : (stepStatus == .inProgress ? Color(red: 0.145, green: 0.388, blue: 0.922) : Color(red: 0.294, green: 0.333, blue: 0.388)),
                backgroundColor: stepStatus == .complete ? Color(red: 0.941, green: 0.992, blue: 0.957) : (stepStatus == .inProgress ? Color(red: 0.937, green: 0.969, blue: 1.0) : Color(red: 0.976, green: 0.980, blue: 0.984)),
                statusBackgroundColor: stepStatus == .complete ? Color(red: 0.863, green: 0.988, blue: 0.906) : (stepStatus == .inProgress ? Color(red: 0.859, green: 0.918, blue: 0.996) : Color(red: 0.898, green: 0.906, blue: 0.922)),
                borderColor: stepStatus == .complete ? Color(red: 0.733, green: 0.969, blue: 0.816) : (stepStatus == .inProgress ? Color(red: 0.376, green: 0.647, blue: 0.980) : Color(red: 0.898, green: 0.906, blue: 0.922)),
                useGradient: stepStatus == .inProgress
            ))
        case .composing:
            let iconName = stepStatus == .complete ? "checkmark" : (stepStatus == .inProgress ? "circle.dotted" : "clock.fill")
            return AnyView(generationStepCard(
                icon: iconName,
                iconColor: stepStatus == .complete ? Color(red: 0.133, green: 0.773, blue: 0.369) : (stepStatus == .inProgress ? nil : Color(red: 0.820, green: 0.835, blue: 0.859)),
                title: "Composing Music",
                description: "Creating melodies and harmonies",
                statusText: stepStatus == .complete ? "Complete" : (stepStatus == .inProgress ? "In Progress" : "Pending"),
                statusTextColor: stepStatus == .complete ? Color(red: 0.086, green: 0.639, blue: 0.290) : (stepStatus == .inProgress ? Color(red: 0.145, green: 0.388, blue: 0.922) : Color(red: 0.294, green: 0.333, blue: 0.388)),
                backgroundColor: stepStatus == .complete ? Color(red: 0.941, green: 0.992, blue: 0.957) : (stepStatus == .inProgress ? Color(red: 0.937, green: 0.969, blue: 1.0) : Color(red: 0.976, green: 0.980, blue: 0.984)),
                statusBackgroundColor: stepStatus == .complete ? Color(red: 0.863, green: 0.988, blue: 0.906) : (stepStatus == .inProgress ? Color(red: 0.859, green: 0.918, blue: 0.996) : Color(red: 0.898, green: 0.906, blue: 0.922)),
                borderColor: stepStatus == .complete ? Color(red: 0.733, green: 0.969, blue: 0.816) : (stepStatus == .inProgress ? Color(red: 0.376, green: 0.647, blue: 0.980) : Color(red: 0.898, green: 0.906, blue: 0.922)),
                useGradient: stepStatus == .inProgress
            ))
        case .finalizing:
            let iconName = stepStatus == .complete ? "checkmark" : (stepStatus == .inProgress ? "circle.dotted" : "clock.fill")
            return AnyView(generationStepCard(
                icon: iconName,
                iconColor: stepStatus == .complete ? Color(red: 0.133, green: 0.773, blue: 0.369) : (stepStatus == .inProgress ? nil : Color(red: 0.820, green: 0.835, blue: 0.859)),
                title: "Finalizing Audio",
                description: "Rendering and optimizing",
                statusText: stepStatus == .complete ? "Complete" : (stepStatus == .inProgress ? "In Progress" : "Pending"),
                statusTextColor: stepStatus == .complete ? Color(red: 0.086, green: 0.639, blue: 0.290) : (stepStatus == .inProgress ? Color(red: 0.145, green: 0.388, blue: 0.922) : Color(red: 0.294, green: 0.333, blue: 0.388)),
                backgroundColor: stepStatus == .complete ? Color(red: 0.941, green: 0.992, blue: 0.957) : (stepStatus == .inProgress ? Color(red: 0.937, green: 0.969, blue: 1.0) : Color(red: 0.976, green: 0.980, blue: 0.984)),
                statusBackgroundColor: stepStatus == .complete ? Color(red: 0.863, green: 0.988, blue: 0.906) : (stepStatus == .inProgress ? Color(red: 0.859, green: 0.918, blue: 0.996) : Color(red: 0.898, green: 0.906, blue: 0.922)),
                borderColor: stepStatus == .complete ? Color(red: 0.733, green: 0.969, blue: 0.816) : (stepStatus == .inProgress ? Color(red: 0.376, green: 0.647, blue: 0.980) : Color(red: 0.898, green: 0.906, blue: 0.922)),
                useGradient: stepStatus == .inProgress
            ))
        }
    }
    
    private func startStepTimer() {
        stopStepTimer()
        stepTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation {
                switch currentStep {
                case .analyzing:
                    currentStep = .composing
                case .composing:
                    currentStep = .finalizing
                case .finalizing:
                    currentStep = .analyzing
                }
            }
        }
    }
    
    private func stopStepTimer() {
        stepTimer?.invalidate()
        stepTimer = nil
    }
    
    private func startQueueTimer() {
        stopQueueTimer()
        // Уменьшаем позицию в очереди каждые 2 секунды
        queueTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            withAnimation {
                if queuePosition > 1 {
                    queuePosition -= 1
                } else {
                    // Когда очередь закончилась, можно начать заново или остановиться
                    queuePosition = queueTotal
                }
            }
        }
    }
    
    private func stopQueueTimer() {
        queueTimer?.invalidate()
        queueTimer = nil
    }
    
    enum StepStatus {
        case complete
        case inProgress
        case pending
    }
    
    private func getStepStatus(for step: GenerationStep) -> StepStatus {
        let stepRaw = step.rawValue
        let currentRaw = currentStep.rawValue
        
        if stepRaw < currentRaw {
            return .complete
        } else if stepRaw == currentRaw {
            return .inProgress
        } else {
            return .pending
        }
    }
    
    private func generationStepCard(
        icon: String,
        iconColor: Color?,
        title: String,
        description: String,
        statusText: String,
        statusTextColor: Color,
        backgroundColor: Color,
        statusBackgroundColor: Color,
        borderColor: Color,
        useGradient: Bool = false
    ) -> some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                if useGradient {
                    Circle()
                        .fill(AppGradients.inProgressGradient)
                        .frame(width: 48, height: 48)
                } else {
                    Circle()
                        .fill(iconColor ?? Color.clear)
                        .frame(width: 48, height: 48)
                }
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
            
            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Status badge
            Text(statusText)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(statusTextColor)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(statusBackgroundColor)
                .cornerRadius(12)
        }
        .padding(16)
        .background(backgroundColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}

struct WhileYouWaitCard: View {
    let icon: String
    let title: String
    let description: String
    let gradient: LinearGradient
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Иконка слева
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(gradient)
                    .frame(width: 48, height: 48)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                
                if icon.contains(".") {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                } else {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            }
            
            // Текст справа
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding(16)
        .background(gradient.opacity(0.1))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(gradient, lineWidth: 1)
        )
    }
}

#Preview {
    CreatingMusicView()
        .environmentObject(AppState())
}
