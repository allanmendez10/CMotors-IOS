//
//  CompanyModel.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/29/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation


struct CompanyModel:Codable{
    
    let id:Int
    let name:String
    let address:String
    let lat:Double
    let lon:Double
    let status:String
    let logo:String
    let distance:String
    
    init(name:String,address:String,lat:Double,lon:Double,status:String,logo:String,id:Int,distance:String) {
        self.id = id
        self.name =  name
        self.address =  address
        self.lat =  lat
        self.lon =  lon
        self.status =  status
        self.logo =  logo
        self.distance = distance
    }
    
}

