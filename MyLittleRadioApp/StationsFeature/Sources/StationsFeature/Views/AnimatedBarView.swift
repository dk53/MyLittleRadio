import SwiftUI

struct AnimatedBarView: View {

    enum Constants {
        static let animationDuration: Double = 0.5
        static let frameWidth: CGFloat = 30
        static let frameHeight: CGFloat = 40
        static let barSpacing: CGFloat = 4
        static let barCornerRadius: CGFloat = 3
        static let barWidth: CGFloat = 3
        static let barMaxHeight: CGFloat = 22

        // Animation speeds for each bar
        static let speed1: Double = 1.5
        static let speed2: Double = 1.2
        static let speed3: Double = 1.0
        static let speed4: Double = 1.7

        // Low heights for each bar in the animation
        static let lowHeight1: CGFloat = 0.4
        static let lowHeight2: CGFloat = 0.3
        static let lowHeight3: CGFloat = 0.5
        static let lowHeight4: CGFloat = 0.3
        static let lowHeight5: CGFloat = 0.5
    }

    @State private var drawingHeight = true

    private var animation: Animation {
        return .linear(duration: Constants.animationDuration).repeatForever()
    }

    var body: some View {
        HStack(spacing: Constants.barSpacing) {
            bar(low: Constants.lowHeight1)
                .animation(animation.speed(Constants.speed1), value: drawingHeight)
            bar(low: Constants.lowHeight2)
                .animation(animation.speed(Constants.speed2), value: drawingHeight)
            bar(low: Constants.lowHeight3)
                .animation(animation.speed(Constants.speed3), value: drawingHeight)
            bar(low: Constants.lowHeight4)
                .animation(animation.speed(Constants.speed4), value: drawingHeight)
            bar(low: Constants.lowHeight5)
                .animation(animation.speed(Constants.speed3), value: drawingHeight)
        }
        .frame(width: Constants.frameWidth)
        .onAppear {
            drawingHeight.toggle()
        }
        .frame(height: Constants.frameHeight)
    }

    private func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: Constants.barCornerRadius)
            .fill(.white.gradient)
            .frame(height: (drawingHeight ? high : low) * Constants.barMaxHeight)
            .frame(width: Constants.barWidth)
    }
}
