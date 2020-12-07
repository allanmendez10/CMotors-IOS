//
//  Repository.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/27/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class UserRepository {
    
       static func getUser() -> [NSManagedObject]?{
        let  appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<User>  = User.fetchRequest()
        do {
            let userResul = try context.fetch(request)
            
            return userResul
            
        } catch let error {
            print("Error \(error.localizedDescription)")
        }
        
        return nil
        
    }
    
    static func deleteUser(){
        let  appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let list  = self.getUser()
        
        for userP in list! {
            let user =  userP as! User
            
            do {
                context.delete(user)
                
                try context.save()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func saveUser(userP:UserModel){
        let  appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let user  = NSManagedObject(entity: userEntity!, insertInto: context) as! User
        
        user.name = userP.name
        user.surname = userP.lastname
        user.address = userP.address
        user.phone = userP.phone
        user.email = userP.email
        user.img = userP.img
        
        do {
            context.insert(user)
            
            try  context.save()
        } catch let error  {
            print("Error \(error.localizedDescription.description)")
        }
        
    }
    
    
}
