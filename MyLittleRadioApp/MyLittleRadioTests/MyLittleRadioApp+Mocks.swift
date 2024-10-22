@testable import MyLittleRadio

extension Station {
    
    static let defaultStation = Station(id: "1",
                                        title: "France Inter",
                                        brandId: "FRANCEINTER",
                                        hasTimeshift: true,
                                        shortTitle: "Inter",
                                        type: .onAir,
                                        streamUrl: "https://icecast.radiofrance.fr/franceinter-midfi.mp3",
                                        analytics: .init(value: "france_inter",
                                                         stationAudienceId: 3),
                                        liveRule: "apprf_inter_player",
                                        colors: .init(primary: "#e20134"),
                                        isMusical: false,
                                        assets: nil)
}
