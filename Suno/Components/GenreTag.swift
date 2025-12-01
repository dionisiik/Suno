import SwiftUI

struct GenreTag: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                Text(text)
                    .font(.system(size: 13))
            }
            .foregroundColor(.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(white: 0.8), lineWidth: 1)
            )
        }
    }
}

#Preview {
    HStack {
        GenreTag(icon: "bolt.fill", text: "Energetic Pop", color: .orange)
        GenreTag(icon: "moon.fill", text: "Chill Lofi", color: .blue)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}



