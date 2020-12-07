//
//  ItemTableViewCell.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/7/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation
import UIKit


class ItemTableViewCell: UITableViewCell {
    
    //var
    var background: UIView!
    
    //components UI
    @IBOutlet weak var cbItem: UIButton!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     //   cbItem.addTarget(self, action: #selector(self.onclickDateCheckMark), for: .touchUpInside)//Target
        cbItem.setImage(UIImage.init(systemName: "checkmark.square.fill"), for: UIControl.State.selected)//When selected
        cbItem.setImage(UIImage.init(systemName: "app"), for: UIControl.State.normal)//When selected
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    
     func onclickDateCheckMark() {
        if cbItem.isSelected == true {
            cbItem.isSelected = false
            print("not Selected")
        }else {
            cbItem.isSelected = true
            print("Selected")
            
        }
      //  delegateItem?.didCheckItem(object: <#T##Any#>, isChecked: sender.isSelected)
    }
    
}
