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

        if let article = article {
            titleLabel.text = article.title
            dateLabel.text = article.date
            authorsLabel.text = article.authors
            imageView = article.image
        }
    }


}
