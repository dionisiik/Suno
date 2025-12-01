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
                    
                    Image(systemName: track.icon)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
                
                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.yellow)
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
                        Image(systemName: "headphones")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.6))
                        Text(track.quality == .hq ? "HQ Audio" : "Standard")
                            .font(.system(size: 11))
                            .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.6))
                    }
                    
                    Text(track.durationString)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(red: 1.0, green: 0.5, blue: 0.0))
                        .cornerRadius(8)
                }
            }
            
            Spacer()
            
            Button(action: onTap) {
                ZStack {
                    Circle()
                        .fill(Color(red: 0.6, green: 0.2, blue: 1.0))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
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
}


