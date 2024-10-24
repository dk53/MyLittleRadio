import SwiftUI
import ComposableArchitecture

struct AppView: View {

    @Perception.Bindable var store: StoreOf<AppFeature>
    @Namespace private var animationNamespace
    
    init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithPerceptionTracking {
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack {
                    StationsView(
                        store: store.scope(state: \.stationsFeature, action: \.stationsFeature),
                        animationNamespace: animationNamespace
                    )
                    .allowsHitTesting(!viewStore.isDetailViewPresented)
                    .blur(radius: viewStore.isDetailViewPresented ? 10 : 0)

                    if let selectedStation = viewStore.selectedStation {
                        StationDetailsView(
                            store: store.scope(state: \.stationDetailsFeature, action: \.stationDetailsFeature),
                            onDismiss: {
                                viewStore.send(.dismissStationDetails)
                            }, animationNamespace: animationNamespace, animationIDs: AnimationIDs(
                                textId: selectedStation.title,
                                backgroundId: "\(selectedStation.title)_background",
                                namespace: animationNamespace
                            )
                        )
                    }
                }
//                .animation(.spring(), value: viewStore.selectedStation)
            }
        }
    }
}
