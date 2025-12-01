import SwiftUI
import Foundation

struct TipCard: View {
    let iconImageName: String
    let title: String
    let description: String
    let color: Color
    
    // Computed property для текста с justify alignment и line height
    private var attributedDescription: AttributedString {
        var attributedString = AttributedString(description)
        
        // Создаем paragraph style для justify alignment и line height
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified  // Выравнивание по ширине
        paragraphStyle.lineHeightMultiple = 1.4  // Line height (1.2 = 120% от размера шрифта)
        paragraphStyle.lineSpacing = 2  // Дополнительный межстрочный интервал
        
        // Применяем стили к тексту
        attributedString.font = .system(size: 12)
        attributedString.foregroundColor = .gray
        
       
        let range = attributedString.startIndex..<attributedString.endIndex
     
        
        return attributedString
    }
    
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
                
                Text(attributedDescription)
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



