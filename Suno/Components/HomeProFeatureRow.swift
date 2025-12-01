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


