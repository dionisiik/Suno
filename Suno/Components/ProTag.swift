import SwiftUI

struct ProTag: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(color)
            
            Text(text)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    Color(red: 0.898, green: 0.906, blue: 0.922), // #E5E7EB
                    lineWidth: 1
                )
        )
    }
}

#Preview {
    ProTag(icon: "bolt.fill", text: "Instant", color: .orange)
        .padding()
        .background(Color.gray.opacity(0.1))
}



