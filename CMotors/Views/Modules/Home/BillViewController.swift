//
//  BillViewController.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/9/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit

class BillViewController: UIViewController, ViewControllerProtocol {
    
    var itemsSelected: [ItemModel]?
    var price = 0.0
    
    // constants
    let cellHeight = 65
    
    //UI components
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPay: UIButton!
    
    
    //datasource
    private var dataSource : TableViewDataSourceUtil<BillTableViewCell,ItemModel>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden =  false

        didInitController()
    }
    
    func didInitController() {
        self.btnPay.setTitle("Pay ₡ \(self.price)", for: .normal)
        updateDataSource()
    }
    
    
    @IBAction func didBtnApplyPayment(_ sender: Any) {
        GeneralUtil.showAlert(title: "Purchase made", message:"Thanks for making the purchase through CMotors", context: self , handler: {
            (alert) in
            self.goToHomeController()
        }
        )
    }
    
    @IBAction func didGoBack(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func goToHomeController(){

       self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func updateDataSource(){
        
        if let list = self.itemsSelected{
            self.dataSource = TableViewDataSourceUtil(cellIdentifier: "billIdentifier", items: list ,cellHeight:CGFloat(self.cellHeight), configureCell: { (cell, evm) in
                cell.lblBillItemDescription.text = evm.name
                cell.lblBillItemPrice.text = "₡\(evm.price)"
                
            })
            
            DispatchQueue.main.async {
                self.tableView.dataSource = self.dataSource
                self.tableView.delegate =  self.dataSource
                self.tableView.reloadData()
            }
            
        }
    }
    
}
