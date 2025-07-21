
import Foundation

// MARK: - MovieResponse
struct TMDBMovieResponse: Codable {
    let results: [TMDBMovie]
}

// MARK: - Movie
struct TMDBMovie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
