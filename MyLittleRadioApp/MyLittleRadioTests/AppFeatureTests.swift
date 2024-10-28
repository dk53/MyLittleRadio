import XCTest
import ComposableArchitecture
import Core

@testable import MyLittleRadio

class AppFeatureTests: XCTestCase {

    @MainActor
    func testPlayStationThroughAppFeature() async {
        let station = Station.mock1

        let store = TestStore(
            initialState: AppFeature.State(
                stationsFeature: .init(
                    stations: [Station.mock1],
                    selectedStation: Station.mock1
                ),
                selectedStation: Station.mock1
            ),
            reducer: { AppFeature() }
        )

        store.exhaustivity = .off

        await store.send(.stationsFeature(.selectStation(station))) {
            $0.selectedStation = station
            $0.isDetailViewPresented = true
            $0.stationDetailsFeature.selectedStation = station
        }

        await store.send(.audioPlayerFeature(.playPauseTapped))

        await store.receive(\.audioPlayerFeature.playerStatusChanged) {
            $0.audioPlayerFeature.isPlaying = true
        }
    }
}
