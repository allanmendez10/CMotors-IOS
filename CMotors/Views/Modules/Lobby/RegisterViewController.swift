//
//  RegisterViewController.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/29/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, ViewControllerProtocol {
    
    //var
    var imagePicker: UIImagePickerController!
    
    // UI
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var lblTitlePasswords: UILabel!
    
    
    //ViewModel
    private var userViewModel : UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden =  false
        self.didInitController()
        // Do any additional setup after loading the view.
    }
    
    func didInitController() {
        
        if userViewModel == nil {
            userViewModel = UserViewModel()
        }
        
        
        
        callToDoAction()
        customButton()
        
        
        let cameraTap = UITapGestureRecognizer(target: self, action: #selector(cameraTapped))
        imgProfilePicture.isUserInteractionEnabled = true
        imgProfilePicture.addGestureRecognizer(cameraTap)
    }
    
    @objc func cameraTapped() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }
    
    @IBAction func didRegister(_ sender: Any) {
        
        if validateData(){
            
            GeneralUtil.showSpinner(onView: self.view)
            
            let userModel =  UserModel(name:txtName.text!,surname: txtLastName.text!,
                                       address: txtAddress.text!,email: txtEmail.text!,phone: txtPhone.text!,password: txtPassword!.text!,user_image: (self.imgProfilePicture.image?.accessibilityIdentifier != nil ? imgProfilePicture.image!.pngData()!:"test".data(using: .utf8)!))
            
            userViewModel.registerWithPod(user: userModel)
            
        }
        
    }
    
    
    
    @IBAction func onTextChanged(_ sender: Any) {
        
        customButton()
        
    }
    
    func customButton(){
        
        let flag = validateData()
        
        self.btnRegister.isEnabled = flag
        
        if flag {
            self.btnRegister.alpha = 1.0
        }else{
            self.btnRegister.alpha = 0.5
        }
        
    }
    
    func callToDoAction(){
    
        self.userViewModel =  UserViewModel()
        self.userViewModel.bindUserViewModelToController = {
            self.goToHome(response: self.userViewModel.empData)
        }
    }
    
    func goToHome(response:UserResponse!){
        GeneralUtil.removeSpinner()

        DispatchQueue.main.async {
            if response != nil && response.data != nil && (response.isSuccessFull != nil) {
                
                self.performSegue(withIdentifier: "goToHomeFromRegister", sender: self)
                UserRepository.deleteUser()
                UserRepository.saveUser(userP: response.data!)
                
            }else{
                GeneralUtil.showAlert(title: "Warning", message: response != nil ? response.message! : "An error has been ocurred",context:self)
            }
        }
    }
    
    
    func validateData() -> Bool {
        var validateTextFields = GeneralUtil.validateDataTextfields(textFields: [txtName,txtEmail,txtAddress,txtEmail,txtPassword,txtConfirmPassword])
        
        
        validateTextFields =  doPasswordsMatch() && validateTextFields
        
        return validateTextFields
        
    }
    
    
    func doPasswordsMatch() -> Bool {
        
        let validatePassword = (txtPassword.text == txtConfirmPassword.text)
        
        
        if !validatePassword{
            lblTitlePasswords.isHidden = false
        }else{
            lblTitlePasswords.isHidden = true
            
        }
        
        return validatePassword
    }
    
}



extension RegisterViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
            case .camera:
                imagePicker.sourceType = .camera
            case .photoLibrary:
                imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Saving Image here
    @IBAction func save(_ sender: AnyObject) {
        guard let selectedImage = imgProfilePicture.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            GeneralUtil.showAlert(title: "Save error", message: error.localizedDescription,context: self)
        } else {
            GeneralUtil.showAlert(title: "Saved!", message: "Your image has been saved to your photos.",context: self)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imgProfilePicture.image = selectedImage
        imgProfilePicture.image?.accessibilityIdentifier = "selected"
    }
    
    
}
