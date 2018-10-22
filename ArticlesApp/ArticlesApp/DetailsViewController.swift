import UIKit
import Kingfisher

class DetailsViewController : UIViewController {
    var article : Article?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"

        guard let article = article else {
            return
        }

        titleLabel.text = article.title
        dateLabel.text = article.date
        authorsLabel.text = article.authors
        let url = URL(string: article.imageUrl)
        imageView.kf.setImage(with: url)

    }
}
