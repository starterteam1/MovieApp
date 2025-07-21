
import Foundation
import Alamofire

class SearchViewModel {

    var allMovies: [Movie] = [] // API에서 가져온 모든 영화
    var filteredMovies: [Movie] = [] // 필터링된 영화

    var onDataUpdate: (() -> Void)?

    func searchMovies(query: String) {
        let apiKey = "6e4904f94750392cbc1c1b705377e7ae"
        let url: String
        var parameters: [String: Any] = ["api_key": apiKey]

        if query.isEmpty {
            url = "https://api.themoviedb.org/3/movie/upcoming"
            // Upcoming API doesn't need a 'query' parameter
        } else {
            url = "https://api.themoviedb.org/3/search/movie"
            parameters["query"] = query
        }

        AF.request(url, method: .get, parameters: parameters).responseDecodable(of: MovieResponse.self) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let movieResponse):
                self.allMovies = movieResponse.results
                self.filterMovies(with: query) // 검색어가 있으면 필터링, 없으면 전체 표시
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    func filterMovies(with searchText: String) {
        if searchText.isEmpty {
            filteredMovies = allMovies
        } else {
            filteredMovies = allMovies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        onDataUpdate?()
    }
}
