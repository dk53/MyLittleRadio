import SwiftUI
import ComposableArchitecture

@main
struct MyLittleRadioApp: App {

    var body: some Scene {
        WindowGroup {
            WithPerceptionTracking {
                NavigationStack {
                    AppView(
                        store: Store(initialState: AppFeature.State()) { AppFeature() }
                    )
                }
            }
        }
    }
}
