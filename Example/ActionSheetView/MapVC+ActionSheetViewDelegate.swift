//
//  MapVC+ActionSheetViewDelegate.swift
//  ActionSheetView_Example
//
//  Created by José Lucas Souza das Chagas on 11/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ActionSheetView

extension MapVC:ActionSheetViewDelegate{
    
    
    func initialSize() -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: 130)
    }
    
    func finalSize() -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 100)
    }
    
    func bottomVC(_ vc: UIViewController) {        
        //vc.view.layer.cornerRadius = 15
        let searchVC = vc as! MapSearchVC
        
        searchVC.showOnMap = {
            (item) in
            self.presentOnMap(item: item)
        }
        
    }

}
