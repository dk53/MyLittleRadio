import SwiftUI
import ComposableArchitecture

struct StationDetailsView: View {
    @Perception.Bindable var store: StoreOf<StationDetailsFeature>

    private var onDismiss: () -> Void

    init(
        store: StoreOf<StationDetailsFeature>,
        onDismiss: @escaping () -> Void
    ) {
        self.store = store
        self.onDismiss = onDismiss
    }

    var body: some View {
        WithPerceptionTracking {
            if let selectedStation = store.selectedStation {
                Rectangle()
                    .fill(Color(selectedStation.colors.primary.toColor ?? .gray))
                    .overlay(
                        VStack {
                            HStack {
                                Text(selectedStation.title)
                                    .font(.title)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(selectedStation.colors.primary.toColor?.isLight ?? true ? .black : .white)

                                Spacer()

                                Button(action: onDismiss) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(selectedStation.colors.primary.toColor?.isLight ?? true ? .black : .white)
                                        .padding()
                                }
                            }
                            .padding(.top, 16)

                            Button(action: {
                                store.send(.togglePlayPause)
                            }) {
                                Image(systemName: store.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(selectedStation.colors.primary.toColor?.isLight ?? true ? .black : .white)
                                    .padding(.top, 20)
                            }

                            Spacer()
                        } .padding()
                    )
                    .ignoresSafeArea()
            }
        }
    }
}
