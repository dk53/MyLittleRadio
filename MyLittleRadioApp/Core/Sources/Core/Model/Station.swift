// Copyright © Radio France. All rights reserved.

import Foundation

public struct StationsResponse: Codable {
    public let stations: [Station]
}

public struct Station: Equatable, Codable, Identifiable, Sendable {

    public struct Analytics: Codable, Equatable, Sendable {
        public let value: String
        public let stationAudienceId: Int
    }

    public struct Colors: Codable, Equatable, Sendable {
        public let primary: String
    }

    public struct Assets: Codable, Equatable, Sendable {
        public let squareImageUrl: String?
    }

    public enum RadioType: String, Equatable, Codable, Sendable {
        case onAir = "on_air"
        case locale
    }

    public let id: String
    public let title: String
    public let brandId: String
    public let hasTimeshift: Bool
    public let shortTitle: String
    public let type: RadioType
    public let streamUrl: String
    public let analytics: Analytics
    public let liveRule: String
    public let colors: Colors
    public let isMusical: Bool
    public let assets: Assets?

    init(id: String,
         title: String,
         brandId: String,
         hasTimeshift: Bool,
         shortTitle: String,
         type: RadioType,
         streamUrl: String,
         analytics: Analytics,
         liveRule: String,
         colors: Colors,
         isMusical: Bool,
         assets: Assets? = nil) {
        self.id = id
        self.title = title
        self.brandId = brandId
        self.hasTimeshift = hasTimeshift
        self.shortTitle = shortTitle
        self.type = type
        self.streamUrl = streamUrl
        self.analytics = analytics
        self.liveRule = liveRule
        self.colors = colors
        self.isMusical = isMusical
        self.assets = assets
    }
}

public extension Station {

    var url: URL? {
        return URL(string: streamUrl)
    }
}
