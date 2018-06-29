import Foundation

enum DataManagerError: Error {
    case Unknown
    case FailedRequest
    case InvalidResponse

}

final class DataManager {
    func fetchArticles() {
        let url = API.BaseURL

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let articles = try? JSONSerialization.jsonObject(with: data!, options: []) as! [[String : AnyObject]] {
                print(articles)

            } else {
                print("Could not deserialize JSON.")
            }
        }

        task.resume()

    }
}
