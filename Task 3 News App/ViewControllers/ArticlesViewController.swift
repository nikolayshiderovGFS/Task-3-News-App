//
//  ArticlesViewController.swift
//  Task 3 News App
//
//  Created by Nikolay Shiderov on 2.11.21.
//

import UIKit

class ArticlesViewController: UIViewController {
    

    
    @IBOutlet weak var tableView: UITableView!
    
    private var lastSelectedRowIndex: Int?
    
    var category: String = ""
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.capitalized
        fetchJSONData {
            self.tableView.reloadData()
        }
    
    }
    
    func viewWillAppear() {
        fetchJSONData {
            self.tableView.reloadData()
        }
    }
    
    func fetchJSONData(completed: @escaping () -> ()) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=\(self.category)&apiKey=ba99f7060c7c4280a03c25949ff46ea1")
        
        guard url != nil else {
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    let articlesFeed = try decoder.decode(ArticlesFeed.self, from: data!)
                    self.articles = articlesFeed.articles!
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("Error in JSON parsing")
                }
            }
        }.resume()
    }
}

extension ArticlesViewController: UITableViewDelegate {
    
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.articleTitle.text = self.articles[indexPath.row].title
        if let imageUrl = articles[indexPath.row].urlToImage {
            cell.articleImage.downloadFrom(link: imageUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.lastSelectedRowIndex = indexPath.row
        performSegue(withIdentifier: "toArticleDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArticleDetailsViewController {
            destination.article = articles[lastSelectedRowIndex!]
        }
    }
}
