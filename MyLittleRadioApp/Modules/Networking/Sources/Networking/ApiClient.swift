// Copyright © Radio France. All rights reserved.

import Dependencies
import DependenciesMacros
import Core

@DependencyClient
public struct ApiClient: Sendable {

    public var fetchStations: @Sendable () async throws -> [Station] = { [] }
}
