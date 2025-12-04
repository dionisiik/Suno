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
    
    private var isPro: Bool {
        appState.user.isPro
    }
    
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
                    
                    // Pro benefits только для Pro пользователей
                    if isPro {
                        activeProBenefitsSection
                    }
                    
                    queuePositionSection
                    generationProgressSection
                    generationStepsSection
                    audioQualitySection
                    
                    // Free-only секции
                    if !isPro {
                        watermarkNoticeSection
                    }
                    
                    whileYouWaitSection
                    
                    // Free-only секции
                    if !isPro {
                        proVsFreeSection
                        skipTheWaitSection
                    }
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
            if !isPro {
                startQueueTimer()
            }
        }
        .onDisappear {
            stopStepTimer()
            stopQueueTimer()
        }
    }
    
    // MARK: - Sections
    
    private var headerSection: some View {
        HStack {
            // Back button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            // Title
            Text("Creating Your Music")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            // PRO или Upgrade кнопка в зависимости от статуса
            Button(action: {
                // Переключаем статус Pro/Free для демонстрации
                appState.user.isPro.toggle()
                
                // Управляем таймером очереди в зависимости от нового статуса
                if appState.user.isPro {
                    // Если стал Pro - останавливаем таймер очереди
                    stopQueueTimer()
                } else {
                    // Если стал Free - запускаем таймер очереди
                    startQueueTimer()
                }
            }) {
                HStack(spacing: 6) {
                    Image("proCrownWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    Text(isPro ? "PRO" : "Upgrade")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                }
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(AppGradients.redOrange)
                .cornerRadius(20)
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
            // Заголовок с иконкой quotePurple
            HStack(spacing: 8) {
                Image("quotePurple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
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
                    
                    Text(isPro ? "Instant processing" : "Free tier processing")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Queue position indicator (только для Free)
                if !isPro {
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("#\(queuePosition)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("of \(queueTotal)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // Прогресс-бар (только для Free)
            if !isPro {
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
                
                // Кнопка Skip the wait (только для Free)
                VStack(spacing: 12) {
                    // Текст
                    Text("Skip the wait with Pro")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Кнопка Upgrade Now
                    Button(action: {}) {
                        Text("Upgrade Now")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(AppGradients.redOrange)
                            .cornerRadius(12)
                    }
                }
                .padding(.top, 4)
            }
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
    
    private var activeProBenefitsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Active Pro Benefits")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
            
            VStack(spacing: 12) {
                proBenefitCard(
                    leftGradient: AppGradients.green,
                    title: "Instant Processing",
                    subtitle: "No queue wait time",
                    rightIcon: "lightningYellow"
                )
                
                proBenefitCard(
                    leftGradient: AppGradients.blue,
                    title: "HQ Audio Quality",
                    subtitle: "Studio-grade output",
                    rightIcon: "headphonesPink"
                )
                
                proBenefitCard(
                    leftGradient: AppGradients.pink,
                    title: "No Watermarks",
                    subtitle: "Clean, professional export",
                    rightIcon: "circleQuestionPink"
                )
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
                        .fill(
                            isPro 
                            ? AppGradients.redOrange 
                            : LinearGradient(
                                colors: [Color(red: 0.820, green: 0.835, blue: 0.859)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        ) // #D1D5DB для Free
                        .frame(width: 32, height: 32)
                    
                    if isPro {
                        Image("qualityWhite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
                
                Text("Audio Quality")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // Tag в зависимости от статуса
                Text(isPro ? "PRO" : "Standard")
                    .font(.system(size: 12, weight: isPro ? .bold : .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        isPro 
                        ? AppGradients.redOrange 
                        : LinearGradient(
                            colors: [Color(red: 0.294, green: 0.333, blue: 0.388)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    ) // #4B5563 для Free
                    .cornerRadius(12)
            }
            
            // Description только для Free
            if !isPro {
                Text("Your track will be generated in standard quality (128 kbps)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                // Upgrade section только для Free
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
            
            // Grid с ячейками качества
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 12
            ) {
                audioQualityCard(
                    icon: "qualityWhite",
                    label: "Quality",
                    value: isPro ? "320 kbps" : "128 kbps",
                    gradient: AppGradients.pink,
                    borderColor: Color(red: 0.753, green: 0.518, blue: 0.988) // #C084FC - первый цвет pink градиента
                )
                
                audioQualityCard(
                    icon: "formatWhite",
                    label: "Format",
                    value: "MP3/WAV",
                    gradient: AppGradients.blue,
                    borderColor: Color(red: 0.376, green: 0.647, blue: 0.980) // #60A5FA - первый цвет blue градиента
                )
                
                audioQualityCard(
                    icon: "clock.fill",
                    label: "Duration",
                    value: "1:00 min",
                    gradient: AppGradients.redOrange,
                    borderColor: Color(red: 0.984, green: 0.573, blue: 0.235) // #FB923C - первый цвет redOrange градиента
                )
                
                audioQualityCard(
                    icon: "watermarkWhite",
                    label: "Watermark",
                    value: isPro ? "None" : "Yes",
                    gradient: AppGradients.green,
                    borderColor: Color(red: 0.290, green: 0.871, blue: 0.502) // #4ADE80 - первый цвет green градиента
                )
            }
        }
        .padding(16)
        .background(
            isPro 
            ? AppGradients.dailyCreditsBackground 
            : LinearGradient(
                colors: [Color(red: 0.976, green: 0.980, blue: 0.984)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        ) // #F9FAFB для Free
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isPro ? Color(red: 0.996, green: 0.843, blue: 0.667) : Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #FED7AA для Pro, #E5E7EB для Free
        )
        .padding(.horizontal, 20)
    }
    
    private var watermarkNoticeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header с иконкой
            HStack(spacing: 12) {
                // Иконка информации
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.980, green: 0.800, blue: 0.082)) // Желтый #FACC15
                        .frame(width: 32, height: 32)
                    
                    Text("i")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("Watermark Notice")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            // Основной текст
            Text("Your generated artwork will include a small watermark. Remove it by upgrading to Pro.")
                .font(.system(size: 12))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            
            // Подсказка с иконкой вопроса
            HStack(spacing: 6) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.631, green: 0.380, blue: 0.027)) // #A16207
                
                Text("Pro members get clean exports")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color(red: 0.631, green: 0.380, blue: 0.027)) // #A16207
            }
        }
        .padding(16)
        .background(Color(red: 0.996, green: 0.988, blue: 0.910)) // #FEFCE8
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.996, green: 0.941, blue: 0.541), lineWidth: 1) // #FEF08A
        )
        .padding(.horizontal, 20)
    }
    
    private var proVsFreeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header с иконкой короны
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppGradients.pink)
                        .frame(width: 48, height: 48)
                    
                    Image("proCrownWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
                
                Text("Pro vs Free")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Text("See what you're missing")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
            
            // Секции сравнения
            VStack(spacing: 12) {
                proVsFreeRow(
                    icon: "lightningYellow",
                    title: "Generation Speed",
                    freeValue: "45s wait",
                    proValue: "Instant",
                    iconGradient: AppGradients.redOrange
                )
                
                proVsFreeRow(
                    icon: "headphonesPink",
                    title: "Audio Quality",
                    freeValue: "Standard",
                    proValue: "HQ Studio",
                    iconGradient: AppGradients.blue
                )
                
                proVsFreeRow(
                    icon: "questionmark.circle.fill",
                    title: "Watermarks",
                    freeValue: "Visible",
                    proValue: "Removed",
                    iconGradient: AppGradients.pink
                )
                
                proVsFreeRow(
                    icon: "infinity",
                    title: "Daily Limit",
                    freeValue: "5 songs",
                    proValue: "Unlimited",
                    iconGradient: AppGradients.green
                )
            }
        }
        .padding(20)
        .background(AppGradients.proBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(red: 0.847, green: 0.706, blue: 0.996), lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
    
    private var skipTheWaitSection: some View {
        VStack(spacing: 20) {
            // Иконка ракета
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(width: 64, height: 64)
                .overlay(
                    Image("rocketPurple")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                )
            
            // Заголовок
            Text("Skip the Wait Forever")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            // Описание
            Text("Get instant generation + HQ audio + unlimited creations")
                .font(.system(size: 12))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            // Кнопка
            Button(action: {}) {
                Text("Try Pro Free for 3 Days")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.859, green: 0.153, blue: 0.467)) // #DB2777
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
            }
            
            // Текст под кнопкой
            Text("Then $9.99/month. Cancel anytime.")
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(32)
        .background(AppGradients.orangePinkPurple)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
        )
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 20)
    }
    
    private func audioQualityCard(
        icon: String,
        label: String,
        value: String,
        gradient: LinearGradient,
        borderColor: Color? = nil
    ) -> some View {
        VStack(spacing: 12) {
            // Иконка с градиентом
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(gradient)
                    .frame(width: 48, height: 48)
                
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
            
            // Label
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            // Value
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            Group {
                if let borderColor = borderColor {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor, lineWidth: 1)
                }
            }
        )
    }
    
    private func proBenefitCard(
        leftGradient: LinearGradient,
        title: String,
        subtitle: String,
        rightIcon: String
    ) -> some View {
        HStack(spacing: 12) {
            // Левая иконка с градиентом и галочкой
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(leftGradient)
                    .frame(width: 40, height: 40)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                
                Image(systemName: "checkmark")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            
            // Текст
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Правая иконка
            Image(rightIcon)
                .resizable()
                .scaledToFit()
                // Для circleQuestionPink немного увеличиваем размер,
                // чтобы визуально совпадал с иконкой молнии выше
                .frame(width: rightIcon == "circleQuestionPink" ? 22 : 18,
                       height: rightIcon == "circleQuestionPink" ? 22 : 18)
        }
        .padding(16)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(leftGradient, lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(leftGradient.opacity(0.08))
        )
        .cornerRadius(16)
    }
    
    private func proVsFreeRow(
        icon: String,
        title: String,
        freeValue: String,
        proValue: String,
        iconGradient: LinearGradient
    ) -> some View {
        HStack(spacing: 12) {
            // Иконка
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconGradient)
                    .frame(width: 32, height: 32)
                
                if icon.contains(".") {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                } else if icon == "infinity" {
                    Image(systemName: "infinity")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
            }
            
            // Название
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            // Значения
            VStack(alignment: .trailing, spacing: 2) {
                Text(freeValue)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .strikethrough() // Зачеркнутый текст
                
                Text(proValue)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color(red: 0.925, green: 0.282, blue: 0.600)) // #EC4899 pink
            }
        }
        .frame(height: 58) // Фиксированная высота
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
        )
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
