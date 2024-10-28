import Dependencies

public extension DependencyValues {

    var audioPlayerClient: AudioPlayerClient {
        get { self[AudioPlayerClient.self] }
        set { self[AudioPlayerClient.self] = newValue }
    }
}

extension AudioPlayerClient: DependencyKey {

    public static let liveValue: Self = {
        let manager = AudioPlayerManager()

        return Self(
            playStream: { url in
                await manager.playStream(url: url)
            },
            pause: {
                await manager.pause()
            },
            stop: {
                await manager.stop()
            }
        )
    }()
}

extension AudioPlayerClient: TestDependencyKey {

    public static let previewValue = Self()
    public static let testValue = Self()
}
