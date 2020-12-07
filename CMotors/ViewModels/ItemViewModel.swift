//
//  ItemsViewModel.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/7/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit
import ANetwork

class ItemViewModel: NSObject {
    
    
    var repo : Repository?
    private(set) var empData : ItemResponse! {
        didSet {
            self.bindItemsViewModelToController()
        }
    }
    
    var bindItemsViewModelToController : (() -> ()) = {}
    
     init(id_company: Int) {
        super.init()
        self.repo = Repository(url:HttpURL.url.description)
        self.getItems(id_company: id_company)
    }
    
    
    func getItems(id_company:Int){
        self.repo!.executeMethodWithoutRequestObject(path: "api/v1/item/getItems/\(id_company)",method: .get,
                                                     onSuccess: {
                                                        (items:ItemResponse) in
                                                        self.empData = items
                                                        
                                                        
        }, onError: {
            error in
            
            self.empData = nil
            
        })
    }
    
    
}
