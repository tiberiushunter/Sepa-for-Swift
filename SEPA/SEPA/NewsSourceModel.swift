//
//  NewsSourceModel.swift
//  SEPA
//
//  Created by Welek Samuel on 28/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import Foundation

class NewsSourceModel {
    private var id: String
    private var name: String
    
    required init(id: String, name: String){
        self.id = id
        self.name = name
    }
    
    func getId() -> String{
        return id
    }
    
    func getName() -> String{
        return name
    }
    
    func setId(id: String){
        self.id = id
    }
    
    func setName(name: String){
        self.name = name
    }
}
