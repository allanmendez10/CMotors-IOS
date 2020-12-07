//
//  Items.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/7/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation

struct ItemModel : Codable{
    
    
    let id:Int
    let name:String
    let price:Double
    let description:String
    let quantity:Int
    let status:String
    let id_company:Int

    
    init(name:String,price:Double,description:String,quantity:Int,id_company:Int,status:String = "", id:Int = 0) {
        self.name =  name
        self.price =  price
        self.description =  description
        self.quantity =  quantity
        self.status =  status
        self.id_company =  id_company
        self.id =  id
    }
    
    
}
