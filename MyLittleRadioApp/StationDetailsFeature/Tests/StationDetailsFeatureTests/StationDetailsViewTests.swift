import XCTest
import ComposableArchitecture
import Core
import AudioPlayerFeature

@testable import StationDetailsFeature

final class StationDetailsFeatureTests: XCTestCase {

    @MainActor
    func testTogglePlayPause() async {
        let store = TestStore(
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
