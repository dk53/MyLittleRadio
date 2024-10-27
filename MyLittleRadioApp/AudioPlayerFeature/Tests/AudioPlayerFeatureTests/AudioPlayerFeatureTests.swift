import XCTest
import ComposableArchitecture
import Foundation
import Core

@testable import AudioPlayerFeature

final class AudioPlayerFeatureTests: XCTestCase {

    @MainActor
    func testPlayPauseTappedWhenPlaying() async {
        let audioPlayerClientMock = AudioPlayerClient(
            playStream: { _ in },
            pause: { },
            stop: { }
        )

        let store = TestStore(
            initialState: AudioPlayerFeature.State(
                isPlaying: false,
                activeStation: .mock1
            ),
            reducer: {
                AudioPlayerFeature()
            },
            withDependencies: {
                $0.audioPlayerClient = audioPlayerClientMock
            }
        )

        await store.send(.playPauseTapped)

        await store.receive(.playerStatusChanged(isPlaying: true)) {
            $0.isPlaying = true
        }
    }

    @MainActor
    func testPauseTappedWhenPlaying() async {
        let audioPlayerClientMock = AudioPlayerClient(
            playStream: { _ in },
            pause: { },
            stop: { }
        )

        let store = TestStore(
            initialState: AudioPlayerFeature.State(
                isPlaying: true,
                activeStation: .mock1
            ),
            reducer: {
                AudioPlayerFeature()
            },
            withDependencies: {
                $0.audioPlayerClient = audioPlayerClientMock
            }
        )


        await store.send(.playPauseTapped)

        await store.receive(.playerStatusChanged(isPlaying: false)) {
            $0.isPlaying = false
        }
    }

    @MainActor
    func testSetStationUrl() async {
        let store = TestStore(
            initialState: AudioPlayerFeature.State(),
            reducer: { AudioPlayerFeature() }
        )

        let testStation = Station.mock1

        await store.send(.setActiveStation(station: testStation)) {
            $0.activeStation = testStation
        }
    }
}

