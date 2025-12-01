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
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    ProTag(icon: "bolt.fill", text: "Instant", color: .orange)
        .padding()
        .background(Color.gray.opacity(0.1))
}



