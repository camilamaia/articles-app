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

            if let articlesDictionary = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                if let articlesList = mapper.map(articlesDict: articlesDictionary!) {
                    completion(Result.Success(data: articlesList))
                } else {
                    completion(Result.Error(type: .SerializationError))
                }
            } else {
                completion(Result.Error(type: .SerializationError))
            }
        })

        task.resume()
    }
}

protocol ArticleMappable {
    func map(articlesDict: [[String : AnyObject]]) -> [Article]?
}

struct ArticleMapper: ArticleMappable {

    func map(articlesDict: [[String : AnyObject]]) -> [Article]? {
        var articles = [Article]()

        for article in articlesDict {
            let jsonData = try? JSONSerialization.data(withJSONObject: article, options: [])

            do {
                let myStruct = try JSONDecoder().decode(Article.self, from: jsonData!)
                articles.append(myStruct)
            }
            catch {
                return nil
            }
        }

        return articles
    }
}
