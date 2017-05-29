//
//  Utilities.swift
//  SEPA
//
//  Created by Welek Samuel on 29/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

class Utilities {
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func convertToCelsius(fahrenheit: Double) -> Double {
        return Double(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
    
    func getDateFromTimestamp(timestamp: Double)->String{
        let currentDate = NSDate(timeIntervalSince1970: timestamp)
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return String(dateFormatter.stringFromDate(currentDate))
    }
    
    
}
