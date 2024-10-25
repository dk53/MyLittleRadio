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
                let backgroundColor = selectedStation.colors.primary.toColor
                let foregroundColor: Color = backgroundColor.isLight ? .black : .white
                Rectangle()
                    .fill(backgroundColor)
                    .overlay(
                        VStack {
                            HStack {
                                Text(selectedStation.title)
                                    .font(.title)
                                    .padding()
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(foregroundColor)

                                Spacer()

                                Button(action: onDismiss) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(foregroundColor)
                                        .padding()
                                }
                            }
                            .padding(.top, 16)
                            Button(action: {
                                store.send(.togglePlayPause)
                            }, label: {
                                Image(systemName: store.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(foregroundColor)
                                    .padding(.top, 20)
                            })
                            Spacer()
                        } .padding()
                    )
                    .ignoresSafeArea()
            }
        }
    }
}
