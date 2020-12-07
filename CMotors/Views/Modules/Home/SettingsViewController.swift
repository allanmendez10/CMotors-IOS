//
//  SettingsViewController.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/9/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    private var queue: DispatchQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            
            GeneralUtil.showSpinner(onView: self.view)
        }
        queue = DispatchQueue(label: "work-queeue")
        
        self.addDivisorLine()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didSignOut(_ sender: Any) {
        UserRepository.deleteUser()
        goToHomeController()
        
    }
    
    func goToHomeController(){
        
        // let vc = UIStoryboard.init(name: "Home", bundle:Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        self.stopLocation()
        self.navigationController?.popToRootViewController(animated: true)
        // self.navigationController?.viewControllers.remove(at: 4)
        
    }
    
    
    func addDivisorLine()  {
        
        let lineView = UIView(frame: CGRect(x:0,
                                            y:  40 ,
                                            width: self.lblUserName.frame.width,
                                            height: 1
            )
        )
        
        lineView.backgroundColor = UIColor.black
        self.lblUserName.addSubview(lineView)
        showUserName()
        
        
    }
    
    func showUserName(){
        
        let users = UserRepository.getUser()
        
        if users != nil && users!.count > 0 {
            let user =  users![0] as! User
            self.lblUserName.text =  "\(user.name!) \(user.surname!)"
            if user.img!.contains("user_image"){
                
                queue?.async {
                    self.showProfilePicture(routeImage: user.img!)
                    
                }
            }else{
                DispatchQueue.main.async {
                    
                    GeneralUtil.removeSpinner()
                }
            }
        }
    }
    
    func showProfilePicture(routeImage: String){
        
        
        let url = URL(string:HttpURL.url.description + routeImage)
        do {
            
            let image: UIImage = UIImage(data: try Data(contentsOf: url!))!
            DispatchQueue.main.async {
                self.imageView.image =  image
                GeneralUtil.removeSpinner()
                
            }
            
        } catch let error {
            DispatchQueue.main.async {

            GeneralUtil.showAlert(title: "Warning", message: "An error has been ocurred",context:self)

            print(error.localizedDescription)
            }
        }
        do{
            DispatchQueue.main.async {

                           GeneralUtil.removeSpinner()
                           
                       }
            
        }
        // }
        
    }
    
    func stopLocation()  {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            locManager.stopUpdatingLocation()
            locManager.delegate = nil
        }
        
    }
    
    
    
    
}

