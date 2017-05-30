//
//  NewsTableViewCell.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class NewsTableCell: UITableViewCell {
    
    
    @IBOutlet weak var lblHeadline: UILabel!
  
    @IBOutlet weak var articleImage: UIWebView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    var newsHeadline = ""
    var newsDescription = ""
    var author = ""
    var url = ""
    var urlToImage = ""
    var publishedAt = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }
    
 
    
}