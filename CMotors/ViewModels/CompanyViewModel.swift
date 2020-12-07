//
//  CompanyViewModel.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/29/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation
import ANetwork

class CompanyViewModel:  NSObject {
    
    private var repo : Repository?
    private var repository : CompanyRepository!
    private(set) var empData : CompanyResponse! {
        didSet {
            self.bindCompanyViewModelToController()
        }
    }
    
    var bindCompanyViewModelToController : (() -> ()) = {}
    
     init(lat:Double = 9.971447, lng : Double = -84.027451) {
        super.init()
        self.repository = CompanyRepository()
        self.repo = Repository(url:HttpURL.url.description)
        getCompaniesWithPod(lat:lat, lng:lng)
    }
    
    
    
    func getCompaniesWithPod(lat:Double, lng : Double){
            
        self.repo!.executeMethodWithRequestObject(path: "api/v1/company/getCompanies", method: .post, object: ["lat":lat,"lng":lng],
                                  onSuccess: {
                                    (companyResponse:CompanyResponse) in
                                    self.empData = companyResponse
                                    
                                    
        }, onError: {
            error in
            
            self.empData = nil
     
            
        })
    }
    
}
