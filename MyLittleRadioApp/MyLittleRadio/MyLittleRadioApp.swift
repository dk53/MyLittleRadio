import SwiftUI

import ComposableArchitecture
import Dependencies
import AudioPlayerFeature

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
