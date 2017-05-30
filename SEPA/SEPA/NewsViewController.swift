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
    var newsSources: Array<NewsSourceModel> = []
    
    var flag = false
    
    let reuseIdentifier = "tableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     //   NSUserDefaults.standardUserDefaults().setObject(Bool(true), forKey:"newsSource_bbcNews")
        
    //    let bbcNewsSource = NSUserDefaults.standardUserDefaults().objectForKey("newsSource_bbcNews") as! Bool
        
    //    if(bbcNewsSource == true){
        //    newsSources.append("BBC News")
     //   }
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getNewsSources() { jsonString in
            if let jsonDictionary = Utilities().convertStringToDictionary(jsonString as String){
                if let sources = jsonDictionary["sources"] as? [Dictionary<String, AnyObject>]{
                    for i in 0 ..< sources.count {
                        let newsSource = NewsSourceModel(
                            id: String(sources[i]["id"]!),
                            name: String(sources[i]["name"]!)
                        )
                        self.newsSources.append(newsSource)
                    }
                    for i in 0 ..< self.newsSources.count {
                        self.getNewsArticles(self.newsSources[i].getId()) { jsonString in
                            if let jsonDictionary = Utilities().convertStringToDictionary(jsonString as String){
                                if let articles = jsonDictionary["articles"] as? [Dictionary<String, AnyObject>]{
                                    for i in 0 ..< articles.count {
                                        let newsArticle = NewsArticleModel(
                                            newsSourceId: self.newsSources[i].getId(),
                                            newsHeadline: String(articles[i]["title"]!),
                                            newsDescription: String(articles[i]["description"]!),
                                            author: String(articles[i]["author"]!),
                                            url: String(articles[i]["url"]!),
                                            urlToImage: String(articles[i]["urlToImage"]!),
                                            publishedAt: String(articles[i]["publishedAt"]!)
                                        )
                                        self.newsArticles.append(newsArticle)
                                    }
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNewsSources(completion: (NSString) -> ()) {
        let urlPath = NewsSourcesURL().getFullURL()
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
    
    func getNewsArticles(source: String, completion: (NSString) -> ()) {
        let urlPath = NewsArticlesURL(source: source).getFullURL()
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
    
    func getNumberOfArticlesFromSource (section: Int) -> Int {
        var count = 0
        let newsSource = self.newsSources[section].getId()
       
        for i in 0 ..< self.newsArticles.count {
            if (self.newsArticles[i].getNewsSourceId() == newsSource){
                count += 1
            }
        }
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: NewsTableCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewsTableCell
        
        var urlToImage = ""
        
        if(self.newsArticles[indexPath.row].getUrlToImage() != "<null>"){
            urlToImage = self.newsArticles[indexPath.row].getUrlToImage()
        }
        
        cell.lblHeadline.text = self.newsArticles[indexPath.row].getNewsHeadline()
        cell.lblDescription.text = self.newsArticles[indexPath.row].getNewsDescription()
        cell.articleImage.loadRequest(NSURLRequest(URL: NSURL(string: urlToImage)!))
    
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.newsSources[section].getName()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return newsSources.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return getNumberOfArticlesFromSource(section)
        return 10
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       // let header = view as! UITableViewHeaderFooterView
      //  let headerImage = UIImage(named: "bbcNews")
      //  let headerImageView = UIImageView(image: headerImage)
      //  headerImageView.contentMode = .ScaleAspectFill
      //  header.addSubview(headerImageView)
        
    }
}

