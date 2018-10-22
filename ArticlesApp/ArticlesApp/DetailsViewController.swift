import UIKit

class DetailsViewController : UIViewController {
    var article : Article?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"

        guard let article = article else {
            return
        }

        titleLabel.text = article.title
        dateLabel.text = article.date
        authorsLabel.text = article.authors
        imageView = convertToImageView(url: article.imageUrl)
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
