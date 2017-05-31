//
//  NewsArticleViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class NewsArticleViewController : UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var contentUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.loadRequest(NSURLRequest(URL: NSURL(string: contentUrl)!))
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
