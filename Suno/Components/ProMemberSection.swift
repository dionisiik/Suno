import SwiftUI

struct ProMemberSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(AppGradients.redOrange)
                        .frame(width: 48, height: 48)
                    
                    Image("circleQuestionWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("You're a Pro Member!")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Enjoying all premium features")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    ProTag(icon: "bolt.fill", text: "Instant", color: Color(red: 1.0, green: 0.5, blue: 0.0))
                        .frame(width: 137, height: 48)
                    ProTag(icon: "infinity", text: "Unlimited", color: Color(red: 0.6, green: 0.2, blue: 1.0))
                        .frame(width: 137, height: 48)
                }
                
                HStack(spacing: 12) {
                    ProTag(icon: "headphones", text: "HQ Audio", color: Color(red: 1.0, green: 0.4, blue: 0.6))
                        .frame(width: 137, height: 48)
                    ProTag(icon: "checkmark.circle.fill", text: "No Marks", color: .green)
                        .frame(width: 137, height: 48)
                }
            }
        }
        .frame(width: 327, height: 152)
        .padding(.top, 26)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .background(AppGradients.proMemberBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    Color(red: 0.992, green: 0.878, blue: 0.278), // #FDE047
                    lineWidth: 1
                )
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 32)
    }
}

#Preview {
    ProMemberSection()
        .padding()
        .background(Color.gray.opacity(0.1))
}


