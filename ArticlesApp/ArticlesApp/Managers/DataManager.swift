import Foundation

enum DataManagerError: Error {
    case Unknown
    case FailedRequest
    case InvalidResponse
    case SerializationError

}

enum Result<T> {
    case Error(type: DataManagerError)
    case Success(data: T)
}

final class DataManager {
    func fetchArticles(completion: @escaping ((_ result: Result<[Article]>) -> Void)) {
        let url = API.BaseURL
        let urlRequest = URLRequest(url: url)
        let mapper = ArticleMapper()

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if error != nil {
                completion(Result.Error(type: .FailedRequest))
                return
            }

            if let articlesList = mapper.map(data: data!) {
                completion(Result.Success(data: articlesList))
            } else {
                completion(Result.Error(type: .SerializationError))
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
