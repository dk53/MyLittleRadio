extension AudioPlayerClient {

    static let mock = Self(
        playStream: { _ in },
        pause: { },
        stop: { }
    )
}
