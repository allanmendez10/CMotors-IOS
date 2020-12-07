//
//  ViewController.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/27/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,ViewControllerProtocol {
    
    // Storyboard components
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    // ViewModel
    private var userViewModel : UserViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  true
        didInitController()
        
    }
    
    
    func didInitController() {
        
        
        if userViewModel == nil {
            userViewModel = UserViewModel()
        }
        
        self.callToDoAction()
        self.customButton()
        
        //}
        
    }
    
    
    @IBAction func didChangeTextField(_ sender: Any) {
        customButton()
    }
    
    
    @IBAction func didLogin(_ sender: Any) {
        if validateData(){
            GeneralUtil.showSpinner(onView: self.view)
            self.userViewModel.loginWithPod(email:txtEmail.text!,password:txtPassword.text!)
        }
    }
    
    
    func customButton(){
        
        let flag = validateData()
        
        btnLogin.isEnabled = flag
        
        if flag {
            btnLogin.alpha = 1.0
        }else{
            btnLogin.alpha = 0.5
        }
        
    }
    
    func validateData() -> Bool {
        
        return GeneralUtil.validateDataTextfields(textFields: [txtPassword,txtEmail])
        
    }
    
    
    func callToDoAction(){
        
        self.userViewModel =  UserViewModel()
        self.userViewModel.bindUserViewModelToController = {
            self.goToHome(response: self.userViewModel.empData)
        }
    }
    
    func goToHome(response:UserResponse!){
        DispatchQueue.main.async {
            GeneralUtil.removeSpinner()
            if response != nil && response.data != nil && (response.isSuccessFull != nil) {
                DispatchQueue.main.async {
                    UserRepository.saveUser(userP: response.data!)
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }
            }else{
                GeneralUtil.showAlert(title: "Warning", message: response != nil ? response.message! : "An error has been ocurred",context:self)
            }
        }
        
    }
    
    
    func goToHomeDirectly(){
        GeneralUtil.removeSpinner()
        self.performSegue(withIdentifier: "goToHome", sender: self)
        
    }
    
    
    
}

