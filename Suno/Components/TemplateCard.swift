import SwiftUI

struct TemplateCard: View {
    let TemplateIconImageName: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(alignment: .leading, spacing: 12) {
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
                        .multilineTextAlignment(.leading)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Button(action: {}) {
                    Text("Try Template")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(color)
                        .padding(.horizontal, 16)
                        .frame(width: 123, height: 22)
                        .padding(.vertical, 6)
                        .background(.white)
                        .cornerRadius(8)
                }
            }
            .frame(minWidth: 24, maxWidth: .infinity, minHeight: 154, alignment: .leading)
            .padding(16)
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



