//
//  CompanyResponse.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/29/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation

class CompanyResponse: BaseResponse{
    
    var data: [CompanyModel]?
    
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([CompanyModel].self, forKey: .data)
        try super.init(from: decoder)
    }
    
    func getData() -> [CompanyModel] {
        return self.data!
    }
    
}
