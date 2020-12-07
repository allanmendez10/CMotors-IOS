//
//  UserModel.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/27/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation


struct UserModel : Codable {
    
    
    let id:Int //1
    let name:String //2
    let lastname:String //3
    let address:String //4
    let email:String //5
    let phone:String //6
    let password:String //7
    var user_image:Data? //8
    let img:String //8
    let status: String //9
    

    init(name:String,surname:String,address:String,email:String,phone:String,password:String,user_image:Data,status:String = "1", id:Int = 0, img:String = "") {
        self.name =  name
        self.lastname =  surname
        self.address =  address
        self.email =  email
        self.phone =  phone
        self.password =  password
        self.user_image =  user_image
        self.id =  id
        self.status = status
        self.img = img
    }
    
    
}
