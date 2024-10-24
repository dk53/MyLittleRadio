// Copyright © Radio France. All rights reserved.

import SwiftUI

import ComposableArchitecture
import Dependencies

@main
struct MyLittleRadioApp: App {
    
    var body: some Scene {
        WindowGroup {
                NavigationStack {
                    AppView(
                        store: Store(
                            initialState: AppFeature.State(stationsFeature: .init(), isDetailViewPresented: false)) {
                                AppFeature()
                            }
                    )
            }
        }
    }
}

