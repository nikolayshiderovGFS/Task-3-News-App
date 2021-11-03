//
//  ArticleDetailsViewController.swift
//  Task 3 News App
//
//  Created by Nikolay Shiderov on 3.11.21.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (article?.author) != nil {
            authorLabel.text = article?.author
        } else { authorLabel.text = "Anonymous Author" }
        if (article?.title) != nil {
            titleLabel.text = article?.title
        } else {titleLabel.text = "Untitled Article"}
        if (article?.description) != nil {
            descriptionLabel.text = article?.description
        } else { article?.description = "No Article Description Provided"}
        if (article?.publishedAt) != nil {
        publishedAtLabel.text = CommonUtils.convertUTCToLocal(utcDateString: (article?.publishedAt)!)
        } else {article?.publishedAt = "No Publishing Date Provided"}
        if (article?.content) != nil {
        contentLabel.text = article?.content
        } else {contentLabel.text = "No Article Content Provided"}
        if let imageUrl = article?.urlToImage {
            articleImage.downloadFrom(link: imageUrl)
        }
    }
    
    @IBAction func openInWebPressed(_ sender: UIButton) {
        if (article?.url) != nil {
            if let url = URL(string: (article?.url)!) {
                UIApplication.shared.open(url)
            }
        } else { return }
    }
    
}

extension UIImageView {
    func downloadFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
    func downloadFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadFrom(url: url, contentMode: mode)
    }
}
