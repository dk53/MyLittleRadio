import SwiftUI
import ComposableArchitecture
import StationsFeature
import StationDetailsFeature

struct AppView: View {

    enum Constants {
        static let blurRadius: CGFloat = 10
        static let sheetHeight: CGFloat = 250
    }

    @Perception.Bindable var store: StoreOf<AppFeature>

    init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            StationsView(store: store.scope(state: \.stationsFeature, action: \.stationsFeature))
                .allowsHitTesting(!store.isDetailViewPresented)
                .blur(radius: store.isDetailViewPresented ? Constants.blurRadius : 0)
                .sheet(isPresented: Binding(
                    get: { store.state.isDetailViewPresented },
                    set: { _ in store.send(.dismissStationDetails) }
                )) {
                    StationDetailsView(
                        store: store.scope(state: \.stationDetailsFeature, action: \.stationDetailsFeature),
                        onDismiss: {
                            store.send(.dismissStationDetails)
                        }
                    )
                    .presentationDetents([.height(Constants.sheetHeight)])
                    .presentationDragIndicator(.hidden)
                }
        }
    }
}