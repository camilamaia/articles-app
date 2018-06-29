import UIKit

class Article {
    var title: String
    var authors: String
    var date: String
    
    init?(title: String, authors: String, date: String) {
        if title.isEmpty  {
            return nil
        }
        
        self.title = title
        self.authors = authors
        self.date = date
    }
}
