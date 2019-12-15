//
//  LocationFetcher.swift
//  PhotoName
//
//  Created by Luc Derosne on 11/12/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import CoreLocation

class LocationFetcher: NSObject , CLLocationManagerDelegate{
    let manager = CLLocationManager()
    var lastLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start(){
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastLocation = locations.first?.coordinate
    }
    
}
