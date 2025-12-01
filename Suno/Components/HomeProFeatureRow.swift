import SwiftUI

struct HomeProFeatureRow: View {
    let icon: String
    let text: String
    let detail: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 20))
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(detail)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        HomeProFeatureRow(
            icon: "arrow.down.circle.fill",
            text: "Export in Multiple Formats",
            detail: "MP3, WAV, FLAC & more",
            color: .blue
        )
        HomeProFeatureRow(
            icon: "headphones",
            text: "HQ Audio",
            detail: "Studio quality sound",
            color: .pink
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}



