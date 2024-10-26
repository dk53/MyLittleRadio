import SwiftUI

struct PlayPauseButton: View {
    let isPlaying: Bool
    let foregroundColor: Color
    let togglePlayPause: () -> Void

    var body: some View {
        Button(action: togglePlayPause) {
            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(foregroundColor)
                .padding(.top, 20)
        }
    }
}
