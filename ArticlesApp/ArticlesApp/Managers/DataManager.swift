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
        var result = [Article]()

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in

            if error != nil {
                completion(Result.Error(type: .FailedRequest))
                return
            }

            if let articles = try? JSONSerialization.jsonObject(with: data!, options: []) as! [[String : AnyObject]] {

                for article in articles {
                    let jsonData = try? JSONSerialization.data(withJSONObject: article, options: [])

                    do {
                        let myStruct = try JSONDecoder().decode(Article.self, from: jsonData!)
                        result.append(myStruct)
                    }
                    catch {
                        completion(Result.Error(type: .SerializationError))
                    }
                }
                completion(Result.Success(data: result))
            } else {
                completion(Result.Error(type: .SerializationError))
            }
        })
        task.resume()
    }
}
