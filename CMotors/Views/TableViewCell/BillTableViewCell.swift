//
//  BillTableViewCell.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/9/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import Foundation
import UIKit

class BillTableViewCell: UITableViewCell {
    
    //var
    var background: UIView!
    
    //components UI
    @IBOutlet weak var lblBillItemDescription: UILabel!
    @IBOutlet weak var lblBillItemPrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
