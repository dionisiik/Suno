import SwiftUI

struct HomeProFeatureRow: View {
    let HomeProImageName: String
    let text: String
    let detail: String
    let color: AnyShapeStyle
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Rectangle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                    .cornerRadius(12)
                Image(HomeProImageName)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .frame(width: 24)
            }
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
        .frame(maxWidth: .infinity, alignment: .center)   // центрируем HStack внутри
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(16)

    }
}

#Preview {
    VStack(spacing: 12) {
        HomeProFeatureRow(
            HomeProImageName: "exportWhite",
            text: "Export in Multiple Formats",
            detail: "MP3, WAV, FLAC & more",
            color: AnyShapeStyle(AppGradients.blue)
        )
        HomeProFeatureRow(
            HomeProImageName: "headphonesWhite",
            text: "Advanced Audio Controls",
            detail: "Fine-tune every parameter",
            color: AnyShapeStyle(AppGradients.pink)
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}



