import iOSSnapshotTestCase
import SwiftUI
import ComposableArchitecture
import XCTest
import Core

@testable import StationDetailsFeature

@MainActor
final class StationsDetailsViewTests: FBSnapshotTestCase {

    private let canvasSize = CGRect(x: 0, y: 0, width: 300, height: 300)

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testStationsViewSnapshot() {
        let store = Store(
            initialState: StationDetailsFeature.State(selectedStation: Station.mock1),
            reducer: { StationDetailsFeature() }
        )

        let stationsView = StationDetailsView(store: store) {}
        snapshotTest(view: stationsView, id: "StationDetailsView")
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
