import Foundation
import AVFoundation
import ComposableArchitecture

struct AudioPlayerClient {
    var playStream: @Sendable (URL) async -> Void
    var pause: @Sendable () async -> Void
    var stop: @Sendable () async -> Void
}

extension DependencyValues {
    var audioPlayerClient: AudioPlayerClient {
        get { self[AudioPlayerClientKey.self] }
        set { self[AudioPlayerClientKey.self] = newValue }
    }
}

private enum AudioPlayerClientKey: DependencyKey {
    static let liveValue: AudioPlayerClient = .live()
}

extension AudioPlayerClient {
    static func live() -> Self {
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
