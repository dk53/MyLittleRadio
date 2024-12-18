import XCTest
import ComposableArchitecture
import Core

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

        await store.send(.togglePlayPause) {
            $0.isPlaying = false
        }
    }
}
