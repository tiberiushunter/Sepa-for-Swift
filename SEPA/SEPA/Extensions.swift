//
//  Extensions.swift
//  SEPA
//
//  Created by Welek Samuel on 29/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

extension String
{
    var parseJSONString: AnyObject?
    {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        if let jsonData = data {
            do {
                let message = try NSJSONSerialization.JSONObjectWithData(jsonData, options:.MutableContainers)
                if let jsonResult = message as? NSMutableArray {
                    return jsonResult
                }
                else {
                    return nil
                }
            }
            catch let error as NSError {
                print("\(error)")
                return nil
            }
        } else {
            return nil
        }
    }
}