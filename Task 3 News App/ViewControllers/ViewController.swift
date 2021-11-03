//
//  ViewController.swift
//  Task 3 News App
//
//  Created by Nikolay Shiderov on 2.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var readArticlesLabel: UILabel!
    
    private var lastSelectedRowIndex: Int?
    let newsCategories: [String] = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numberOfReadArticles = UserDefaults.standard.integer(forKey: "numberOfReadArticles")
        readArticlesLabel.text = String(numberOfReadArticles)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let numberOfReadArticles = UserDefaults.standard.integer(forKey: "numberOfReadArticles")
        readArticlesLabel.text = String(numberOfReadArticles)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCategoryCell", for: indexPath)
        cell.textLabel?.text = newsCategories[indexPath.row].capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.lastSelectedRowIndex = indexPath.row
        self.performSegue(withIdentifier: "toArticlesVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionation = segue.destination as! ArticlesViewController
        destionation.category = newsCategories[lastSelectedRowIndex!]
    }
}


