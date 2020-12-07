//
//  ItemsViewController.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/7/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, ViewControllerProtocol, TableDataSourceProtocol {
    
    
    
    // constants
    let cellHeight = 70
    var price = 0.0;
    
    //objects
    var company:CompanyModel?
    var itemsSelected: [ItemModel]?
    
    //components
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var btnAddToCar: UIButton!
    
    
    private var viewModel : ItemViewModel!
    private var dataSource : TableViewDataSourceUtil<ItemTableViewCell,ItemModel>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didInitController()

    }
    
    @IBAction func didGoBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    
    func didInitController() {
        
        self.navigationController?.isNavigationBarHidden =  false

        
        GeneralUtil.showSpinner(onView: self.view)
        itemsSelected =  [ItemModel]()
        
        if viewModel == nil {
            viewModel = ItemViewModel(id_company: company!.id)
        }
        
        
        callToDoAction()
        
    }
    
    func callToDoAction(){
        
        self.viewModel!.bindItemsViewModelToController = {
            GeneralUtil.removeSpinner()
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        if let listItems = self.viewModel.empData{
            
            self.dataSource = TableViewDataSourceUtil(cellIdentifier: "itemIdentifier", items: listItems.data! ,cellHeight:CGFloat(self.cellHeight), configureCell: { (cell, evm) in
                cell.lblItemName.text = evm.name
                cell.lblPrecio.text = "₡\(evm.price)"
                
            })
            
            self.dataSource.delegate = self
            
            DispatchQueue.main.async {
                self.tableView.dataSource = self.dataSource
                // self.tableView.delegate =  self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    
    
    func didSelectItem(object: Any) {
        
        let item = object as! ItemModel
        
        print(item.price)
        
    }
    
    
    @IBAction func didClickAddCart(_ sender: Any) {
        
        goToBillController()
    }
    
    
    func goToBillController(){
        
        let vc = UIStoryboard.init(name: "Home", bundle:Bundle.main).instantiateViewController(withIdentifier: "BillViewController") as? BillViewController
        
        vc?.itemsSelected = self.itemsSelected
        vc?.price =  self.price
     
    self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
}


extension ItemViewController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.cellHeight)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
        
        //   let cell = tableView.dequeueReusableCell(withIdentifier: "itemIdentifier", for: indexPath) as! ItemTableViewCell
        
        
        cell.onclickDateCheckMark()
        
        
        let  item = self.viewModel.empData.data![indexPath.row]
        
        btnAddToCar.setTitle("Add to cart . ₡\(self.updateCart(true,object:item))", for: .normal)
        
        
    }
    
    func updateCart(_:Bool, object: ItemModel) -> String{
        
        
        var price = 0.0

        if let index = self.itemsSelected!.firstIndex(where: { $0.id == object.id}) {
            self.itemsSelected!.remove(at: index)
        }else{
            self.itemsSelected!.append(object)
        }
        
        
        if let list = self.itemsSelected {
            
            for item in list {
                price += item.price
            }
            
        }
        
        self.price = price
        customButton(price: price)
        
        return String(price)
        
    }
    
    func customButton(price: Double){
        
        let flag =  price > 0
        
        self.btnAddToCar.isEnabled = flag
        
        if flag {
            self.btnAddToCar.alpha = 1.0
        }else{
            self.btnAddToCar.alpha = 0.5
        }
        
    }
    
}
