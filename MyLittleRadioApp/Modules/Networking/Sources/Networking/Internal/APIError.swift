import Foundation

enum ApiError: LocalizedError {

    case invalidURL
    case decodingError
    case networkError(URLError)
    case unknown

    // MARK: - LocalizedError Description

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .decodingError:
            return "Failed to decode the response data."
        case .networkError(let urlError):
            return "Network error: \(urlError.localizedDescription)"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
