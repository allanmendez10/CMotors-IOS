//
//  UserViewModel.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/27/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation
import ANetwork

class UserViewModel:  NSObject {
    
    var repo : Repository?
    private var repository : UserRepository!
    private(set) var empData : UserResponse! {
        didSet {
            self.bindUserViewModelToController()
        }
    }
    
    var bindUserViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.repository = UserRepository()
        self.repo = Repository(url:HttpURL.url.description)
    }
    

    func registerWithPod(user:UserModel){
        self.repo!.executeMethodWithRequestObject(path: "api/v1/user/register", method: .post,object:user,
                                  onSuccess: {
                                    (user:UserResponse) in
                                    self.empData = user
                                    
                                    
        }, onError: {
            error in
            
            self.empData = nil
            
        }, isMultipart : true)
    }
    
    func loginWithPod(email:String, password:String){

        self.repo!.executeMethodWithRequestObject(path: "api/v1/user/login", method: .post,object:["email": email, "password": password],
                                  onSuccess: {
                                    (user:UserResponse) in
                                    self.empData = user
                                    
                                    
        }, onError: {
            error in
            
            self.empData = nil
            
        })
    }
    
}

