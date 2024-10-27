import iOSSnapshotTestCase
import SwiftUI
import ComposableArchitecture
import Core
import XCTest

@testable import StationsFeature

@MainActor
class StationsViewTests: FBSnapshotTestCase {

    let canvasSize = CGRect(x: 0, y: 0, width: 375, height: 667)

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testStationsViewSnapshot() async {
        let store = Store(
            initialState: StationsFeature.State(
                stations: [
                    Station.mock2,
                    Station.mock3
                ],
                isLoading: false
            ),
            reducer: { StationsFeature()
            }
        )

        let stationsView = StationsView(store: store)
        snapshotTest(view: stationsView, id: "StationViewLoaded")
    }

    func testStationsViewWithMiniPlayerSnapshot() async {
        let store = Store(
            initialState: StationsFeature.State(
                stations: [
                    Station.mock2,
                    Station.mock3
                ],
                activeStation: Station.mock2,
                isPlaying: true
            ),
            reducer: { StationsFeature()
            }
        )

        let stationsView = StationsView(store: store)
        snapshotTest(view: stationsView, id: "StationViewLoadedPlusMiniPlayer")
    }

    @MainActor
    func snapshotTest(view: some View, id: String) {
        let viewController = UIHostingController(rootView: view)

        let window = UIWindow(frame: canvasSize)
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()

        FBSnapshotVerifyView(viewController.view, identifier: id)
    }
}
