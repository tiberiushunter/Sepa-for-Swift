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

    let reuseIdentifier = "tableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView.dataSource = self
        tableView.delegate = self
        
        self.getNewsSources() { jsonString in
            if let jsonDictionary = Utilities().convertStringToDictionary(jsonString as String){
                if let sources = jsonDictionary["sources"] as? [Dictionary<String, AnyObject>]{
                    for i in 0 ..< sources.count {
                        let newsSource = NewsSourceModel(
                            id: String(sources[i]["id"]!),
                            name: String(sources[i]["name"]!)
                        )
                        //Here we check if the User has enabled the News Source in the Settings Page
                        if ((NSUserDefaults.standardUserDefaults().objectForKey("newsSource_" + newsSource.getId())) != nil &&
                            NSUserDefaults.standardUserDefaults().objectForKey("newsSource_" + newsSource.getId()) as! Bool){
                                self.newsSources.append(newsSource)
                        }
                    }
                    for j in 0 ..< self.newsSources.count {
                        self.getNewsArticles(self.newsSources[j].getId()) { jsonString in
                            if let jsonDictionary = Utilities().convertStringToDictionary(jsonString as String){
                                if let articles = jsonDictionary["articles"] as? [Dictionary<String, AnyObject>]{
                                    for k in 0 ..< articles.count {
                                        let newsArticle = NewsArticleModel(
                                            newsSourceId: self.newsSources[j].getId(),
                                            newsHeadline: String(articles[k]["title"]!),
                                            newsDescription: String(articles[k]["description"]!),
                                            author: String(articles[k]["author"]!),
                                            url: String(articles[k]["url"]!),
                                            urlToImage: String(articles[k]["urlToImage"]!),
                                            publishedAt: String(articles[k]["publishedAt"]!)
                                        )
                                        self.newsArticles.append(newsArticle)
                                    }
                                    dispatch_async(dispatch_get_main_queue()){
                                        if(j == self.newsSources.count - 1){
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
        var articleCount = 0
        let newsSourceId = self.newsSources[section].getId()
       
        for i in 0 ..< newsArticles.count {
            if (self.newsArticles[i].getNewsSourceId() == newsSourceId){
                articleCount += 1
            }
        }
        return articleCount
    }
    
    func getArticlesFromSectionId (section: Int) -> Array<NewsArticleModel> {
        var newsArticlesForSection = Array<NewsArticleModel>()
        let newsSourceId = self.newsSources[section].getId()
        
        for i in 0 ..< newsArticles.count {
            if (self.newsArticles[i].getNewsSourceId() == newsSourceId){
                newsArticlesForSection.append(self.newsArticles[i])
            }
        }
        return newsArticlesForSection
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier{
            if (id == "showNewsArticle"){
                let newVc = segue.destinationViewController as! NewsArticleViewController
                if let indexPath = tableView.indexPathForSelectedRow {
                    let cell = tableView.cellForRowAtIndexPath(indexPath) as! NewsTableCell
                    newVc.contentUrl = cell.url
                }
                
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: NewsTableCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewsTableCell
        
        var urlToImage = ""
        
        var newsArticlesForSection = getArticlesFromSectionId(indexPath.section)

        //TODO: Sort this nasty if statement out asking if a string of "<null>" exists!
        if (newsArticlesForSection[indexPath.row].getUrlToImage() != "<null>"){
            urlToImage = newsArticlesForSection[indexPath.row].getUrlToImage()
        }
        
        cell.lblHeadline.text = newsArticlesForSection[indexPath.row].getNewsHeadline()
        cell.lblDescription.text = newsArticlesForSection[indexPath.row].getNewsDescription()
        cell.articleImage.loadRequest(NSURLRequest(URL: NSURL(string: urlToImage)!))
        cell.url = newsArticlesForSection[indexPath.row].getUrl()
        
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
        return getNumberOfArticlesFromSource(section)
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       // let header = view as! UITableViewHeaderFooterView
      //  let headerImage = UIImage(named: "bbcNews")
      //  let headerImageView = UIImageView(image: headerImage)
      //  headerImageView.contentMode = .ScaleAspectFill
      //  header.addSubview(headerImageView)
        
    }
}

