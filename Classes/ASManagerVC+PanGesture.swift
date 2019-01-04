//
//  ASManagerVC+PanGesture.swift
//  ActionSheetView
//
//  Created by José Lucas Souza das Chagas on 02/11/17.
//

import UIKit


extension ASManagerVC{
    
    @discardableResult
    func addPanGes()->UIPanGestureRecognizer{
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(ASManagerVC.didPanOnASView(panGes:)))
        self.containerView?.addGestureRecognizer(panGes)
        return panGes
    }
    
    @objc private func didPanOnASView(panGes:UIPanGestureRecognizer){
        
        let translation = panGes.translation(in: self.view)
        let velocity = panGes.velocity(in: self.view)
        
        if panGes.state == .began || panGes.state == .changed{
            changeDimensionsFor(Desloc: translation.y)
            panGes.setTranslation(CGPoint.zero, in: self.view)
        }
        else{
            let finalSize = self.finalSize
            guard let center = self.containerView?.center else{return}
            let centerY = center.y
            
            if velocity.y < 60 {
                changeToBigDimensions(Animate: true,Duration: 0.2)
            }
            else if velocity.y > 60 {
                changeToSmallDimensions(Animate: true,Duration: 0.2)
            }
            else if centerY < self.view.frame.height - finalSize.height/4{// half more big
                changeToBigDimensions(Animate: true)
            }
            else {//half less big
                changeToSmallDimensions(Animate: true)
            }
        }
        
    }
    

}
