import SwiftUI
import ComposableArchitecture

struct AnimatedBarView: View {

    @State private var drawingHeight = true

    private var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
    
    var body: some View {
        WithPerceptionTracking {
            HStack(spacing: 4) {
                bar(low: 0.4)
                    .animation(animation.speed(1.5), value: drawingHeight)
                bar(low: 0.3)
                    .animation(animation.speed(1.2), value: drawingHeight)
                bar(low: 0.5)
                    .animation(animation.speed(1.0), value: drawingHeight)
                bar(low: 0.3)
                    .animation(animation.speed(1.7), value: drawingHeight)
                bar(low: 0.5)
                    .animation(animation.speed(1.0), value: drawingHeight)
            }
            .frame(width: 30)
            .onAppear {
                drawingHeight.toggle()
            }
            .frame(height: 40)
        }
    }

    private func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(.white.gradient)
            .frame(height: (drawingHeight ? high : low) * 22)
            .frame(width: 3)
    }
}