import UIKit

struct Article {
    var title: String
    var authors: String
    var date: String
    var image: UIImageView?

    init?(title: String, authors: String, date: String, imageUrl: String) {
        if title.isEmpty  {
            return nil
        }
        
        self.title = title
        self.authors = authors
        self.date = date
        self.image = convertToImageView(url: imageUrl)
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

        let url = try container.decode(String.self, forKey: .image_url)
        image = convertToImageView(url: url)

    }

    func convertToImageView(url: String) -> UIImageView? {
        let url = URL(string: url)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                return UIImageView(image: UIImage(data: data!))
            }
        }
        return nil
    }
}
