import UIKit

class Article {
    
    //MARK: Properties
    
    var title: String
    var authors: String
    var date: String
    
    //MARK: Initialization
    
    init?(title: String, authors: String, date: String) {
        if title.isEmpty  {
            return nil
        }
        
        self.title = title
        self.authors = authors
        self.date = date
    }
}
