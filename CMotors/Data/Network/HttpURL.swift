//
//  HttpURL.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/4/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation


enum HttpURL: CustomStringConvertible {
    
    case url
    
    var description: String {
        switch self {
            case .url:
                 return "https://cmotors.herokuapp.com/"
                //return "http://127.0.0.1:3000/"
            
            
        }
    }
}
