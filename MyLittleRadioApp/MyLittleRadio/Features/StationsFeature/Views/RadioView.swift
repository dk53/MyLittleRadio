import SwiftUI
import ComposableArchitecture

struct StationView: View {
    private let title: String
    private let showMusicIcon: Bool
    private let color: UIColor?
    private let animation: AnimationIDs
    
    init(title: String, showMusicIcon: Bool, color: UIColor? = nil, animation: AnimationIDs) {
        self.title = title
        self.showMusicIcon = showMusicIcon
        self.color = color
        self.animation = animation
    }
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                let color = color ?? .gray
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(color))
                        .frame(height: 100)
                        .accessibilityHidden(true)
                        .ifLet(animation.namespace) { view, namespace in
                            view.matchedGeometryEffect(id: animation.background, in: namespace)
                        }
                    
                    HStack {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(color.isLight ? .black : .white)
                            .accessibilityLabel("Station name: \(title)")
                            .ifLet(animation.namespace) { view, namespace in
                                view.matchedGeometryEffect(id: animation.text, in: namespace)
                            }
                        if showMusicIcon {
                            Image(systemName: "music.note")
                                .foregroundColor(color.isLight ? .black : .white)
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        }
    }
}
