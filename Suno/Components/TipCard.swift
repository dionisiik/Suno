import SwiftUI

struct TipCard: View {
    let iconImageName: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Rectangle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                    .cornerRadius(12)
                Image(iconImageName)
                    .foregroundColor(.white)
                    .font(.system(size: 12))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(3)
            }
            Spacer(minLength: 0)
            
        }
        .frame(maxWidth: .infinity, minHeight: 69, maxHeight: 69, alignment: .topLeading)
        .padding(12)
        .background(color.opacity(0.1))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(white: 0.8), lineWidth: 1)
        )

    }
}

#Preview {
    TipCard(
        iconImageName: "bulbWhite",
        title: "Be Specific",
        description: "Include instruments, tempo, and mood for better results. Example: Upbeat acoustic guitar with soft drums, 120 BPM",
        color: .blue
    )
    .padding()
    .background(Color.gray.opacity(0.1))
}



