//
//  GeneralUtil.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/29/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class GeneralUtil {
    
    static var vSpinner : UIView?
    
    static func validateDataTextfields(textFields:[UITextField])->Bool{
        
        for textField in textFields {
            if textField.text!.isEmpty{
                return false
            }
        }
        
        return true
    }
    
    static func convertImageToBase64(image:UIImage) -> String{
        
        let imageData:NSData = image.pngData()! as NSData
        
        
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        
        return strBase64
        
    }
    
    static func showAlert(title: String, message: String, context: UIViewController){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        context.present(ac, animated: true)
    }
    
    
    static func showAlert(title: String, message: String, context: UIViewController, handler: @escaping (UIAlertAction?) -> ()){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        
        context.present(ac, animated: true)
    }
    
    
    static  func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)

        }
        
        self.vSpinner = spinnerView

        
    }
    
    static func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    

}
