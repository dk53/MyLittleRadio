import Foundation
import AVFoundation
import ComposableArchitecture

@DependencyClient
public struct AudioPlayerClient: Sendable {

    public var playStream: @Sendable (URL) async -> Void = { _ in }
    public var pause: @Sendable () async -> Void = {}
    public var stop: @Sendable () async -> Void = {}
}
