import SwiftUI

struct QuickActionCard: View {
    let QuickActionIconImageName: String
    let title: String
    let subtitle: String
    let gradient: LinearGradient
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(gradient)
                        .frame(width: 48, height: 48)
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                    
                    Image(QuickActionIconImageName)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(gradient.opacity(0.1))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(gradient, lineWidth: 1)
            )
        }
    }
}

#Preview {
    QuickActionCard(
        QuickActionIconImageName: "microphoneWhite",
        title: "Voice Input",
        subtitle: "Speak your idea",
        gradient: AppGradients.blue
    )
    .padding()
    .background(Color.gray.opacity(0.1))
}



