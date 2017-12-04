//
//  MapVC.swift
//  ActionSheetView_Example
//
//  Created by José Lucas Souza das Chagas on 11/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MapKit
import ActionSheetView

class MapVC: ASManagerVC {
    let manager = CLLocationManager()

    var stateOne:Bool = true
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        stateOne = !stateOne
        reloadActionSheetView()
    }
    //MARK: - MapView
    
    func setUpMapView(){
        mapView.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func presentOnMap(item:MKMapItem){
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(item.placemark)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
