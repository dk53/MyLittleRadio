import Foundation
import AVFoundation
import ComposableArchitecture

public struct AudioPlayerClient: Sendable {

    public var playStream: @Sendable (URL) async -> Void
    public var pause: @Sendable () async -> Void
    public var stop: @Sendable () async -> Void

    // MARK: - Live Instance

    public static func live() -> Self {
        let player = AVPlayer()

        return Self(
            playStream: { url in
                await MainActor.run {
                    let playerItem = AVPlayerItem(url: url)
                    player.replaceCurrentItem(with: playerItem)
                    player.play()
                }
            },
            pause: {
                await MainActor.run {
                    player.pause()
                }
            },
            stop: {
                await MainActor.run {
                    player.pause()
                    player.replaceCurrentItem(with: nil)
                }
            }
        )
    }
}

// MARK: - AudioPlayerClient Dependency Key

private enum AudioPlayerClientKey: DependencyKey {

    static let liveValue: AudioPlayerClient = .live()
    static let testValue: AudioPlayerClient = .mock
}

// MARK: - DependencyValues Extension

extension DependencyValues {

    var audioPlayerClient: AudioPlayerClient {
        get { self[AudioPlayerClientKey.self] }
        set { self[AudioPlayerClientKey.self] = newValue }
    }
}
