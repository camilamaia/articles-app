import Foundation

enum DataManagerError: Error {
    case Unknown
    case FailedRequest
    case InvalidResponse

}

final class DataManager {
    func fetchArticles() {
        let url = API.BaseURL
        let urlRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let articles = try? JSONSerialization.jsonObject(with: data!, options: []) as! [[String : AnyObject]] {

                for article in articles {
                    let jsonData = try? JSONSerialization.data(withJSONObject: article, options: [])

                    do {
                        let myStruct = try JSONDecoder().decode(Article.self, from: jsonData!)
                        print(myStruct)
                    }
                    catch {
                        print(error)
                    }
                }

            } else {
                print("Could not deserialize JSON.")
            }
        }
        task.resume()
    }
}
