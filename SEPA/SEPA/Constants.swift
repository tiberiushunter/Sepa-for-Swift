//
//  Constants.swift
//  SEPA
//
//  Created by Welek Samuel on 23/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

struct WeatherURL {
    private let baseURL = "https://api.darksky.net/forecast/"
    private let key = "e0b934246f6646b9e8fa88b86bf27f3b/"
    private var coordStr = ""
    
    init (lat: String, long: String){
        self.coordStr = "\(lat),\(long)"
    }
    
    func getFullURL() -> String {
        return baseURL + key + coordStr
    }
}

struct NewsSourcesURL {
    private let baseURL = "https://newsapi.org/v1/sources?"
    private let sortBy = "&sortBy=top"
    private let key = "&apiKey=02f5dd4595a8408b997e26e65d25f91e"
    
    init (){
    }
    
    func getFullURL() -> String {
        return baseURL + sortBy + key
    }
}

struct NewsArticlesURL {
    private let baseURL = "https://newsapi.org/v1/articles?"
    private var source = ""
    private let key = "&apiKey=02f5dd4595a8408b997e26e65d25f91e"
    
    init (source: String){
        self.source = "source=" + source
    }
    
    func getFullURL() -> String {
        return baseURL + source + key
    }
}

struct UnixTimeURL {
    private let baseURL = "http://www.convert-unix-time.com/api?"
    private var timestamp = ""
    private let format = "&format=english"
    private let timezone = "&timezone=London"
    
    init (timestamp: String){
        self.timestamp = "timestamp=\(timestamp)"

    }
    
    func getFullURL() -> String {
        return baseURL + timestamp + format + timezone
    }
}