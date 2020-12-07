//
//  ItemsResponse.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/7/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation

class ItemResponse :BaseResponse{
      
    var data: [ItemModel]?
    
    private enum CodingKeys: String, CodingKey {
          case data
      }

      required init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
        
          self.data = try? container.decode([ItemModel].self, forKey: .data)
          try super.init(from: decoder)
      }
    
}
