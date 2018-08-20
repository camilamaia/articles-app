import UIKit

class ArticlesViewController: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet var articlesTableView: UITableView!

    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleArticles()
        setupView()
    }

    private func setupView() {
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        articlesTableView.isHidden = true
        loadingView.isHidden = false
    }

    private func loadSampleArticles() {
        let manager = DataManager()
        manager.fetchArticles { result in
            switch result {
            case .Error(let error):
                print(error)

            case .Success(let articles):
                self.articles = articles
                DispatchQueue.main.async {
                    self.loadingView.isHidden = true
                    self.articlesTableView.isHidden = false
                    self.articlesTableView.reloadData()
                }
            }
        }
    }
}

extension ArticlesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ArticleTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleTableViewCell else {
            fatalError("The dequeued cell is not an instance of ArticleTableViewCell.")
        }

        let article = articles[indexPath.row]

        cell.titleLabel.text = article.title
        cell.authorsLabel.text = article.authors
        cell.dateLabel.text = article.date

        return cell
    }
}

extension ArticlesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        print(article)
        // TODO: Instantiate next view controller and send the article to it

//        let detailsViewController = DetailsViewController()
//        detailsViewController.article = article
//        present(detailsViewController, animated: true, completion: nil)
    }
}
