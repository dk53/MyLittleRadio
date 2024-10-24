import SwiftUI
import ComposableArchitecture

struct StationDetailsView: View {
    @Perception.Bindable var store: StoreOf<StationDetailsFeature>

    private var onDismiss: () -> Void
    private let animationNamespace: Namespace.ID?
    private let animationIDs: AnimationIDs

    init(
        store: StoreOf<StationDetailsFeature>,
        onDismiss: @escaping () -> Void,
        animationNamespace: Namespace.ID? = nil,
        animationIDs: AnimationIDs
    ) {
        self.store = store
        self.onDismiss = onDismiss
        self.animationNamespace = animationNamespace
        self.animationIDs = animationIDs
    }

    var body: some View {
        WithPerceptionTracking {
            WithViewStore(store, observe: { $0 }) { viewStore in
                if let selectedStation = viewStore.selectedStation {
                    ZStack {
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: onDismiss) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(selectedStation.colors.primary.toColor?.isLight ?? true ? .black : .white)
                                        .padding()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 16)

                            Text(selectedStation.shortTitle)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .foregroundColor(selectedStation.colors.primary.toColor?.isLight ?? true ? .black : .white)
//                                .ifLet(animationNamespace) { view, namespace in
//                                    view.matchedGeometryEffect(id: animationIDs.text, in: namespace)
//                                }

                            Button(action: {
                                viewStore.send(.togglePlayPause)
                            }) {
                                Image(systemName: viewStore.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(selectedStation.colors.primary.toColor?.isLight ?? true ? .black : .white)
                                    .padding(.top, 20)
                            }
                            Spacer()
                        }
                    }
                    .cornerRadius(20)
                    .background(Color(selectedStation.colors.primary.toColor ?? .gray))
                    .frame(width: 300, height: 300)
//                    .ifLet(animationNamespace) { view, namespace in
//                        view.matchedGeometryEffect(id: animationIDs.background, in: namespace)
//                    }
                }
            }
        }
    }
}
