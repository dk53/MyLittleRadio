import XCTest
import ComposableArchitecture
@testable import MyLittleRadio

final class StationDetailsFeatureTests: XCTestCase {

    func testTogglePlayPause() async {
        let store = await TestStore(
            initialState: StationDetailsFeature.State(selectedStation: Station.mock1),
            reducer: { StationDetailsFeature() }
        )

        await store.send(.togglePlayPause) {
            $0.isPlaying = true
        }

        await store.receive(\.audioPlayer.playPauseTapped)

        await store.send(.togglePlayPause) {
            $0.isPlaying = false
        }

        await store.receive(\.audioPlayer.playPauseTapped)
    }
}
