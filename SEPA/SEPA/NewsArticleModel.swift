//
//  NewsArticleModel.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

class NewsArticleModel {
    private var newsHeadline: String
    private var newsDescription: String
    private var author: String
    private var url: String
    private var urlToImage: String
    private var publishedAt: String
    
    required init(newsHeadline: String, newsDescription: String, author: String, url: String, urlToImage: String, publishedAt: String){
        self.newsHeadline = newsHeadline
        self.newsDescription = newsDescription
        self.author = author
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
    
    func getNewsHeadline() -> String{
        return newsHeadline
    }
    
    func getNewsDescription() -> String{
        return newsDescription
    }
    
    func getAuthor() -> String{
        return author
    }
    
    func getUrl() -> String{
        return url
    }

    func getUrlToImage() -> String{
        return urlToImage
    }

    func getPublishedAt() -> String{
        return publishedAt
    }
    
    func setNewsHeadline(newsHeadline: String){
        self.newsHeadline = newsHeadline
    }
    
    func setNewsDescription(newsDescription: String){
        self.newsDescription = newsDescription
    }
    
    func setAuthor(author: String){
        self.author = author
    }
    
    func setUrl(url: String){
        self.url = url
    }
    
    func setUrlToImage(urlToImage: String){
        self.urlToImage = urlToImage
    }
    
    func setPublishedAt(publishedAt: String){
        self.publishedAt = publishedAt
    }
}
