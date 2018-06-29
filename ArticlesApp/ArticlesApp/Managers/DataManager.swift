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
                    let json = """
                    {
                      "title": "Obama Offers Hopeful Vision While Noting Nation's Fears",
                      "authors": "Graham Spencer",
                      "date": "05/26/2014"
                    }
                    """.data(using: .utf8)!
                    do {
                        let myStruct = try JSONDecoder().decode(Article.self, from: json)
                        print(myStruct)
                    }
                    catch {
                        print(error)
                    }
            } else {
                print("Could not deserialize JSON.")
            }
        }
        task.resume()
    }
}
