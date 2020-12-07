//
//  CompanyTableViewCell.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/29/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    //var
    var background: UIView!
    
    //components UI
    @IBOutlet weak var imgCompany: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  self.updateView()
        self.customCell()
        // Initialization code
    }
    

    
    func updateView() {
      //  self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 1
        self.contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.contentView.layer.shadowRadius = 3
        
    }
    
    func customCell(){
        
        
        // SHADOW AND BORDER FOR CELL
        //  contentView.
        contentView.layer.cornerRadius = 2
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemGray3.cgColor
        //contentView.layer.masksToBounds = true
        
        
       /*  contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        
        contentView.layer.shadowRadius = 0.1
        contentView.layer.shadowOpacity = 0.02
        contentView.layer.masksToBounds = false
        
          let margins = UIEdgeInsets(top: 100, left: 0, bottom: 100, right: 0)
         contentView.layer.frame = contentView.layer.frame.inset(by: margins) */
        
      //  contentView.layer.shadowPath = UIBezierPath(roundedRect:contentView.bounds, cornerRadius:contentView.layer.cornerRadius).cgPath
        //contentView.addSubview(background)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    
}
