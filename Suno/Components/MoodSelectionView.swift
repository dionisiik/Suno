import SwiftUI

struct MoodSelectionView: View {
    @Binding var selectedMood: String?
    
    private let moods: [String] = [
        "Happy", "Calm", "Energetic",
        "Sad", "Epic", "Dark",
        "Chill", "Relaxed", "Upbeat"
    ]
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mood")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(moods, id: \.self) { mood in
                    moodButton(for: mood)
                }
            }
        }
    }
    
    private func moodButton(for mood: String) -> some View {
        let isSelected = selectedMood == mood
        
        return Button {
            selectedMood = isSelected ? nil : mood
        } label: {
            Text(mood)
                .font(.system(size: 13))
                .foregroundColor(isSelected ? Color(red: 1.0, green: 0.4, blue: 0.6) : .black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(isSelected ? Color(red: 1.0, green: 0.4, blue: 0.6).opacity(0.1) : Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            isSelected ? Color(red: 1.0, green: 0.4, blue: 0.6) : Color(white: 0.8),
                            lineWidth: isSelected ? 2 : 1
                        )
                )
        }
    }
}

#Preview {
    @State var mood: String? = "Calm"
    
    return MoodSelectionView(selectedMood: $mood)
        .padding()
        .background(Color.gray.opacity(0.1))
}



