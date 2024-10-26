import iOSSnapshotTestCase
import SwiftUI
import ComposableArchitecture
import XCTest
import Core
import AudioPlayerFeature

@testable import StationDetailsFeature

class StationsDetailsViewTests: FBSnapshotTestCase {

    let canvasSize = CGRect(x: 0, y: 0, width: 300, height: 300)

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testStationsViewSnapshot() async {
        let store = await Store(
            initialState: StationDetailsFeature.State(selectedStation: Station.mock1),
            reducer: { StationDetailsFeature() }
        )

        let stationsView = await StationDetailsView(store: store) {}
        await snapshotTest(view: stationsView, id: "StationDetailsView")
    }

    @MainActor
    func snapshotTest(view: some View, id: String) {
        let vc = UIHostingController(rootView: view)

        let window = UIWindow(frame: canvasSize)
        window.rootViewController = vc
        window.makeKeyAndVisible()

        vc.view.setNeedsLayout()
        vc.view.layoutIfNeeded()

        FBSnapshotVerifyView(vc.view, identifier: id)
    }
}
