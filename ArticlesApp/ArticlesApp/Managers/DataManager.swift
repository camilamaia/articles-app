import Foundation

enum DataManagerError: Error {
    case Unknown
    case FailedRequest
    case InvalidResponse

}

final class DataManager {
    func fetchArticles(finished: @escaping ((_ articles: Array<Article>)->Void)) {
        let url = API.BaseURL
        let urlRequest = URLRequest(url: url)
        var result = [Article]()

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in

            if let articles = try? JSONSerialization.jsonObject(with: data!, options: []) as! [[String : AnyObject]] {

                for article in articles {
                    let jsonData = try? JSONSerialization.data(withJSONObject: article, options: [])

                    do {
                        let myStruct = try JSONDecoder().decode(Article.self, from: jsonData!)
                        result += [myStruct]
                    }
                    catch {
                        print(error)
                    }
                }
                finished(result)
            } else {
                print("Could not deserialize JSON.")
            }
        })
        task.resume()
    }
}
