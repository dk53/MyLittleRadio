import XCTest
import ComposableArchitecture
import Foundation
@testable import MyLittleRadio

final class AudioPlayerFeatureTests: XCTestCase {

    @MainActor
    func testPlayPauseTappedWhenPlaying() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(
                isPlaying: true,
                currentStationUrl: URL(string: "https://victor.com/stream.mp3")
            ),
            reducer: { AudioPlayerFeature() }
        )

        let audioPlayerClientMock = AudioPlayerClient(
            playStream: { _ in },
            pause: { },
            stop: { }
        )

        store.dependencies.audioPlayerClient = audioPlayerClientMock
        await store.send(.playPauseTapped)

        await store.receive(.playerStatusChanged(isPlaying: false)) {
            $0.isPlaying = false
        }
    }

    @MainActor
    func testPauseTappedWhenPlaying() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(
                isPlaying: false,
                currentStationUrl: URL(string: "https://victor.com/stream.mp3")
            ),
            reducer: { AudioPlayerFeature() }
        )

        let audioPlayerClientMock = AudioPlayerClient(
            playStream: { _ in },
            pause: { },
            stop: { }
        )

        store.dependencies.audioPlayerClient = audioPlayerClientMock
        await store.send(.playPauseTapped)

        await store.receive(.playerStatusChanged(isPlaying: true)) {
            $0.isPlaying = true
        }
    }

    func testSetStationUrl() async {
        let store = await TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature() }
        )

        let testUrl = URL(string: "https://victor.com/stream.mp3")!

        await store.send(.setStationUrl(testUrl)) {
            $0.currentStationUrl = testUrl
        }
    }
}

