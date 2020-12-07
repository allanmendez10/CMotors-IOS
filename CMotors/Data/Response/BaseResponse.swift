//
//  BaseResponse.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/27/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation


class BaseResponse : Decodable{
    
    var isSuccessFull:Bool?
    var status:Int?
    var message:String?

    private enum CodingKeys: String, CodingKey {
        case isSuccessFull
        case status
        case message
        
    }

    
}
