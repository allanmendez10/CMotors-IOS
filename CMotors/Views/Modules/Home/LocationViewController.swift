//
//  HomeViewController.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 7/27/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    //components
    @IBOutlet weak var mapView: MKMapView!
    
    
    // vars
    let companies:[CompanyModel]? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showPoint()
        
    }
    
    
    func showPoint(){
        
        self.mapView.mapType = MKMapType.standard
        var latitude = 9.9714662
        var longitude = -84.0360611

        if let location =  self.getLocation() {
            latitude = location.coordinate.latitude
            longitude =  location.coordinate.longitude
        }
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion( center: location, latitudinalMeters: CLLocationDistance(exactly: 30000)!, longitudinalMeters: CLLocationDistance(exactly: 30000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
        if let objects = CompanyRepository.getCompanies(){
            for item in objects {
                let company  = item as! Company
                let dbLat = company.lat
                let dbLong = company.lon
                let companyLocation = CLLocationCoordinate2D(latitude: dbLat, longitude: dbLong)
                let companyGPSPoint = MKPointAnnotation()
                companyGPSPoint.title = company.name
                companyGPSPoint.coordinate = companyLocation
                self.mapView.addAnnotation(companyGPSPoint)
            }
            
        }
    }
    
    func getLocation() -> CLLocation? {
           
           let locManager = CLLocationManager()
           locManager.requestWhenInUseAuthorization()
           
           if
              CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
              CLLocationManager.authorizationStatus() ==  .authorizedAlways
           {
               return locManager.location
           }
           
           return nil
       }
    
    
}
