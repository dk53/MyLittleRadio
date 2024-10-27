import SwiftUI

public struct PlayPauseButton: View {

    enum Constants {
        static let defaultIconSize: CGFloat = 60

        static let pulseCircleSizeInset: CGFloat = 20
        static let pulseAnimationDuration: Double = 1.2
        static let pulseScale: CGFloat = 1.5
        static let pulseScaleSecondary: CGFloat = 1.2

        static let primaryCircleOpacity: Double = 0.3
        static let secondaryCircleOpacity: Double = 0.2
        static let primaryLineWidth: CGFloat = 4
        static let secondaryLineWidth: CGFloat = 2

        static let playIcon: String = "play.circle.fill"
        static let pauseIcon: String = "pause.circle.fill"
    }

    private let isPlaying: Bool
    private let foregroundColor: Color
    private let iconSize: CGFloat
    private let togglePlayPause: () -> Void

    @State private var isPulsing = false

    public init(
        isPlaying: Bool,
        foregroundColor: Color,
        iconSize: CGFloat? = nil,
        togglePlayPause: @escaping () -> Void
    ) {
        self.isPlaying = isPlaying
        self.foregroundColor = foregroundColor
        self.iconSize = iconSize ?? Constants.defaultIconSize
        self.togglePlayPause = togglePlayPause
    }

    public var body: some View {
        let pulseCircleSize = iconSize + Constants.pulseCircleSizeInset

        ZStack {
            if isPlaying {
                Circle()
                    .stroke(foregroundColor.opacity(Constants.primaryCircleOpacity),
                            lineWidth: Constants.primaryLineWidth)
                    .frame(width: pulseCircleSize, height: pulseCircleSize)
                    .scaleEffect(isPulsing ? Constants.pulseScale : 1)
                    .opacity(isPulsing ? 0 : 1)
                    .animation(
                        Animation.easeInOut(duration: Constants.pulseAnimationDuration)
                            .repeatForever(autoreverses: true),
                        value: isPulsing
                    )

                Circle()
                    .stroke(foregroundColor.opacity(Constants.secondaryCircleOpacity),
                            lineWidth: Constants.secondaryLineWidth)
                    .frame(width: pulseCircleSize, height: pulseCircleSize)
                    .scaleEffect(isPulsing ? Constants.pulseScaleSecondary : 1)
                    .opacity(isPulsing ? 0 : 1)
                    .animation(
                        Animation.easeInOut(duration: Constants.pulseAnimationDuration * 0.9)
                            .repeatForever(autoreverses: true),
                        value: isPulsing
                    )
            }

            Button(action: togglePlayPause) {
                Image(systemName: isPlaying ? Constants.pauseIcon : Constants.playIcon)
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(foregroundColor)
            }
        }
        .frame(width: pulseCircleSize, height: pulseCircleSize)
        .onAppear { isPulsing = isPlaying }
        .onChange(of: isPlaying) { newValue in
            isPulsing = newValue
        }
    }
}
