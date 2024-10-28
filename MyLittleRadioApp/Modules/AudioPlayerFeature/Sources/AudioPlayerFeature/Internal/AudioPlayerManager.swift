import AVFoundation
import Foundation

final class AudioPlayerManager: Sendable {

    // MARK: - Properties

    private let player = AVPlayer()

    @MainActor
    func playStream(url: URL) async {
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }

    @MainActor
    func pause() async {
        player.pause()
    }

    @MainActor
    func stop() async {
        player.pause()
        player.replaceCurrentItem(with: nil)
    }
}
