import UIKit

struct Article {
    var title: String
    var authors: String
    var date: String
    var imageUrl: String

    init?(title: String, authors: String, date: String, imageUrl: String) {
        if title.isEmpty  {
            return nil
        }
        
        self.title = title
        self.authors = authors
        self.date = date
        self.imageUrl = imageUrl
    }

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case date
        case image_url
    }
}

extension Article: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        authors = try container.decode(String.self, forKey: .authors)
        date = try container.decode(String.self, forKey: .date)
        imageUrl = try container.decode(String.self, forKey: .image_url)
    }
}
