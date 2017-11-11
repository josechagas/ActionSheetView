//
//  MapVC+MKMapViewDelegate.swift
//  ActionSheetView_Example
//
//  Created by José Lucas Souza das Chagas on 11/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MapKit

extension MapVC:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        manager.stopUpdatingLocation()
        mapView.setCenter(userLocation.coordinate, animated: true)
    }
    
}
