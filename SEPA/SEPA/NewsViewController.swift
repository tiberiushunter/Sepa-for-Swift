//
//  NewsViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var passedString = "blank"
    var newsArticles: Array<NewsArticleModel> = []
    var newsSources = ["BBC News"]
    
    let reuseIdentifier = "tableViewCell"

    var jsonString = ""

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getNews { jsonString in
            self.jsonString = jsonString as String
            
            if let jsonDictionary = Utilities().convertStringToDictionary(self.jsonString){
                if let articles = jsonDictionary["articles"] as? [Dictionary<String, AnyObject>]{
                    for i in 0 ..< articles.count {
                        let newsArticle = NewsArticleModel(
                            newsHeadline: String(articles[i]["title"]!),
                            newsDescription: String(articles[i]["description"]!),
                            author: String(articles[i]["author"]!),
                            url: String(articles[i]["url"]!),
                            urlToImage: String(articles[i]["urlToImage"]!),
                            publishedAt: String(articles[i]["publishedAt"]!)
                        )
                        self.newsArticles.append(newsArticle)
                    }
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                }
            }
        }

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNews(completion: (NSString) -> ()) {
        let urlPath = NewsURL().getFullURL()
        let url: NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            completion(jsonString!)
        })
        task.resume()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: NewsTableCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewsTableCell

        let urlToImage = self.newsArticles[indexPath.row].getUrlToImage()
        
        cell.lblHeadline.text = self.newsArticles[indexPath.row].getNewsHeadline()
        cell.lblDescription.text = self.newsArticles[indexPath.row].getNewsDescription()
        cell.articleImage.loadRequest(NSURLRequest(URL: NSURL(string: urlToImage)!))
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.newsSources[0]
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return newsSources.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    

    

}

