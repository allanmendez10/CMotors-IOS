//
//  UserResponse.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/27/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation


class UserResponse :BaseResponse{
    
    var data: UserModel?
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.data = try? container.decode(UserModel.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}
