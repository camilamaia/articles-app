import Foundation

enum DataManagerError: Error {
    case unknown
    case failedRequest
    case invalidResponse
    case serializationError

}

enum Result<T> {
    case error(type: DataManagerError)
    case success(data: T)
}

final class DataManager {

    func fetchArticles(completion: @escaping ((_ result: Result<[Article]>) -> Void)) {
        let url = API.BaseURL
        let urlRequest = URLRequest(url: url)
        let mapper = ArticleMapper()

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if error != nil {
                completion(Result.error(type: .failedRequest))
                return
            }

            if let articlesList = mapper.map(data: data!) {
                completion(Result.success(data: articlesList))
            } else {
                completion(Result.error(type: .serializationError))
            }
        })

        task.resume()
    }
}

protocol ArticleMappable {
    func map(data: Data) -> [Article]?
}

struct ArticleMapper: ArticleMappable {

    func map(data: Data) -> [Article]? {
        do {
            return try JSONDecoder().decode([Article].self, from: data)
        }
        catch  {
            return nil
        }
    }
}
