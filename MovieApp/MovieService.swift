//
// MovieService
// MovieApp
//
// Created by 이돈혁 on 7/16/25
//

import Foundation

struct CreditsResponse: Decodable {
    let crew: [CrewMember]
}

struct CrewMember: Decodable {
    let job: String
    let name: String
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let backdropPath: String?
    let rating: Double?
    let releaseDate: String?

    var fullPosterURL: String? {
        guard let path = posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(path)"
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case overview
        case backdropPath = "backdrop_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
    }
}

class MovieService {
    static let shared = MovieService()
    private init() {}

    private let apiKey = "3f0b7c752e2e20c62178e46099a4bd3e"

    func fetchUpcomingMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=ko-KR&page=1") else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("API Error: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            } catch {
                print("Decoding Error:", error)
                completion([])
            }
        }.resume()
    }

    func fetchNowPlayingMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=ko-KR&page=1") else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("API Error: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            } catch {
                print("Decoding Error:", error)
                completion([])
            }
        }.resume()
    }

    func fetchExclusiveMovies(completion: @escaping ([Movie]) -> Void) {
        let exclusiveIDs = [634492, 507089, 675445, 845111, 438631]
        var exclusiveMovies: [Movie] = []
        let group = DispatchGroup()

        for id in exclusiveIDs {
            group.enter()
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=ko-KR") else {
                group.leave()
                continue
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { group.leave() }

                guard let data = data else {
                    print("API Error (Exclusive): \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    exclusiveMovies.append(movie)
                } catch {
                    print("Decoding Error (Exclusive):", error)
                }
            }.resume()
        }

        group.notify(queue: .main) {
            completion(exclusiveMovies)
        }
    }

    func fetchFeaturedMovies(completion: @escaping ([Movie]) -> Void) {
        let nowPlayingURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=ko-KR&page=1")!
        let popularURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=ko-KR&page=1")!

        let group = DispatchGroup()
        var nowPlayingIDs: Set<Int> = []
        var popularMovies: [Movie] = []

        group.enter()
        URLSession.shared.dataTask(with: nowPlayingURL) { data, _, _ in
            defer { group.leave() }
            if let data = data,
               let decoded = try? JSONDecoder().decode(MovieResponse.self, from: data) {
                nowPlayingIDs = Set(decoded.results.map { $0.id })
            }
        }.resume()

        group.enter()
        URLSession.shared.dataTask(with: popularURL) { data, _, _ in
            defer { group.leave() }
            if let data = data,
               let decoded = try? JSONDecoder().decode(MovieResponse.self, from: data) {
                popularMovies = decoded.results
            }
        }.resume()

        group.notify(queue: .main) {
            let filtered = popularMovies.filter { !nowPlayingIDs.contains($0.id) }
            completion(filtered)
        }
    }
}
