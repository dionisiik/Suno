import SwiftUI

struct TipCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(white: 0.8), lineWidth: 1)
        )
    }
}

#Preview {
    TipCard(
        icon: "lightbulb.fill",
        title: "Be Specific",
        description: "Include instruments, tempo, and mood for better results.",
        color: .blue
    )
    .padding()
    .background(Color.gray.opacity(0.1))
}



