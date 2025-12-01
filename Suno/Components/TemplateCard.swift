import SwiftUI

struct TemplateCard: View {
    let TemplateIconImageName: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 12) {
                ZStack {
                    Rectangle()
                        .fill(color)
                        .frame(width: 40, height: 40)
                        .cornerRadius(12)
                    Image(TemplateIconImageName)
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing) 
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                }
                
                Button(action: {}) {
                    Text("Try Template")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(color)
                        .cornerRadius(8)
                }
            }
            .padding()
            .frame(width: 158, height: 164)
            .background(color.opacity(0.1))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(white: 0.8), lineWidth: 1)
            )
        }
    }
}

#Preview {
    TemplateCard(
        TemplateIconImageName: "cloudWhite",
        title: "Dream Pop",
        subtitle: "Ethereal & atmospheric",
        color: .blue
    )
    .padding()
    .background(Color.gray.opacity(0.1))
}



