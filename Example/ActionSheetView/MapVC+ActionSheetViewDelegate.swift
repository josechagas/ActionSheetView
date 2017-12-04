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
        return CGSize(width: self.view.frame.width - 20*(stateOne ? 1 : 0), height: 130)
    }
    
    func finalSize() -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - (stateOne ? 100 : 40))
    }
    
    func bottomVC(_ vc: UIViewController) {
        /*
        vc.view.layer.shadowColor = UIColor.black.cgColor
        vc.view.layer.shadowOpacity = 0.5
        vc.view.layer.shadowOffset = CGSize(width: 0, height: 2)
        vc.view.layer.shadowRadius = 3
        vc.view.layer.masksToBounds = false
        */
        vc.view.layer.masksToBounds = true
        vc.view.layer.cornerRadius = 15
        vc.view.layer.borderWidth = 1
        vc.view.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.15).cgColor
        let searchVC = vc as! MapSearchVC
        
        searchVC.showOnMap = {
            (item) in
            self.presentOnMap(item: item)
        }
        
    }

}
