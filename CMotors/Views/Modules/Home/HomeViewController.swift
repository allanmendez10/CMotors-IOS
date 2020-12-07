//
//  CompanyViewController.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/30/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, ViewControllerProtocol, TableDataSourceProtocol , CLLocationManagerDelegate{
    
    // constants
    let companyCellHeight = 300
    
    // Components Layout
    @IBOutlet weak var tabBar: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : CompanyViewModel!
    private var dataSource : TableViewDataSourceUtil<CompanyTableViewCell,CompanyModel>!
    
    
    //location
    var locationManager:CLLocationManager!
    var userLocation :CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.didInitController()
        //  self.navigationController?.isNavigationBarHidden =  false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  true
    }
    
    
    func didInitController() {
        self.initLocation()
        GeneralUtil.showSpinner(onView: self.view)
        
        if viewModel == nil {
            if let location =  userLocation {
                viewModel = CompanyViewModel(lat:location.coordinate.latitude.magnitude,lng:location.coordinate.longitude.magnitude)
                
            }else{
                viewModel = CompanyViewModel()
            }
        }
        
        callToDoAction()
        
    }
    
    func initLocation(){
        
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled(){
                locationManager.startUpdatingLocation()
            }else {
                print("Location services are not enabled")
            }
        }
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation!.coordinate.latitude)")
        print("user longitude = \(userLocation!.coordinate.longitude)")
        
        
    }
    
    func callToDoAction(){
        
        
        self.viewModel!.bindCompanyViewModelToController = {
            CompanyRepository.deleteCompanies()
            if let data  = self.viewModel.empData {
                CompanyRepository.saveCompany(companyList: data.getData())
                self.updateDataSource()
                GeneralUtil.removeSpinner()

            }
        }
    }
    
    
    func updateDataSource(){
        
        let company = self.viewModel.empData.getData()
        self.dataSource = TableViewDataSourceUtil(cellIdentifier: "companyIdentifier", items: company,cellHeight:CGFloat(self.companyCellHeight), configureCell: { (cell, evm) in
            cell.lblName.text = evm.name
            cell.lblLocation.text = "\(evm.distance) Km"
            cell.lblAddress.text = evm.address
            cell.imgCompany.image = self.getImage(base64: evm.logo)
            
        })
        
        self.dataSource.delegate = self
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate =  self.dataSource
            self.tableView.reloadData()

        }
        
    }
    
    func getImage(base64:String) -> UIImage? {
        
        
        let base:String?
        if base64.hasPrefix("data:image/jpeg;base64,") {
            base = base64.replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
        }else if base64.hasPrefix("data:image/png;base64,") {
            base = base64.replacingOccurrences(of: "data:image/png;base64,", with: "")
        }else{
            base =  base64
            
        }
        
        let decodedData =  Data(base64Encoded: base!, options: .ignoreUnknownCharacters)
        let image =  UIImage(data: decodedData!)
        if let image = image {
            return image
        }
        return nil
        
        
    }
    
    
    func didSelectItem(object: Any) {
        goToItemController(companySelected: object as! CompanyModel)
    }
    
    
    func goToItemController(companySelected:CompanyModel){
        
        
        let vc = UIStoryboard.init(name: "Home", bundle:Bundle.main).instantiateViewController(withIdentifier: "ItemViewController") as? ItemViewController
        
        vc?.company = companySelected
        //  vc?.delegate = self
        //  vc?.modalPresentationStyle = .fullScreen
        // self.present(vc!, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}

