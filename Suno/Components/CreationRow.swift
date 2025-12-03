import SwiftUI

struct CreationRow: View {
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
        HStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
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
                    
                    Image(track.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
                ZStack {
                    Circle()
                        .fill(AppGradients.redOrange)
                        .frame(width: 20, height: 20)
                    Image("starWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 13, height: 12)
                }
                .offset(x: 4, y: -4)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(track.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(track.timeAgo)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 0.745, green: 0.094, blue: 0.364)) // #BE185D
                        Text(track.quality == .hq ? "HQ Audio" : "Standard")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 0.745, green: 0.094, blue: 0.364)) // #BE185D
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 999)
                            .stroke(Color(red: 0.976, green: 0.659, blue: 0.831), lineWidth: 1) // #F9A8D4
                    )
                    
                    Text(track.durationString)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(Color(red: 0.761, green: 0.255, blue: 0.047)) // #C2410C
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(red: 1.0, green: 0.929, blue: 0.835)) // #FFEDD5
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(white: 0.8), lineWidth: 1)
                        )
                }
            }
            
            Spacer()
            
            Button(action: onTap) {
                ZStack {
                    Circle()
                        .fill(AppGradients.playHomeButtonGradient)
                        .frame(width: 40, height: 40)

                    Image(systemName: "play.fill")   // или твоя иконка
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                }
            }
        }
        .padding()
        .background(Color(red: 0.976, green: 0.980, blue: 0.984)) // #F9FAFB
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.898, green: 0.906, blue: 0.922), lineWidth: 1) // #E5E7EB
        )
    }
}

#Preview {
    let sampleTrack = Track(
        title: "Chill Lofi Beats",
        prompt: "A peaceful lofi beat",
        duration: 90,
        genre: "Lofi",
        mood: "Calm",
        quality: .hq,
        isFavorite: true,
        isDownloaded: false,
        icon: "headphones",
        gradientColors: ["0.6,0.2,1.0", "1.0,0.4,0.6"]
    )
    
    return CreationRow(track: sampleTrack, onTap: {})
        .padding()
        .background(Color.gray.opacity(0.1))
}



