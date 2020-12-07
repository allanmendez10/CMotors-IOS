//
//  CompanyRepository.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/29/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CompanyRepository: NSObject {
    
    
    static func getCompanies() -> [NSManagedObject]?{
        let  appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<Company>  = Company.fetchRequest()
        do {
            let userResul = try context.fetch(request)
            
            return userResul
            
        } catch let error {
            print("Error \(error.localizedDescription)")
        }
        
        return nil
        
    }
    
    static func deleteCompanies(){
        let  appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let list  = getCompanies()
        
        for userP in list! {
            let user =  userP as! Company
            
            do {
                context.delete(user)
                
                try context.save()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func saveCompany(companyList:[CompanyModel]!){
        let  appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
    
        if let companies =  companyList {
            
            for item in companies {
                
                let userEntity = NSEntityDescription.entity(forEntityName: "Company", in: context)
                let company  = NSManagedObject(entity: userEntity!, insertInto: context) as! Company
                
                company.name = item.name
                company.lat = item.lat
                company.address = item.address
                company.lon = item.lon
                company.distance = Double(item.distance)!
                //user.img = userP.img
                
                do {
                    try  context.save()
                } catch let error  {
                    print("Error \(error.localizedDescription)")
                }
                
            }
            
        }
        
        
        
    }
    
}
