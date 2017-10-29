//
//  ASManagerVC+Gestures.swift
//  Learning_InteractiveTransactions
//
//  Created by José Lucas Souza das Chagas on 27/10/17.
//  Copyright © 2017 joselucas. All rights reserved.
//

import UIKit
extension ASManagerVC{
    
    func addGestures(){
        //addTapGes()
        let pan = addPanGes()
        let upSwipe = addUpSwipeGes()
        let downSwipe = addDownSwipeGes()
        
        pan.require(toFail: upSwipe)
        pan.require(toFail: downSwipe)
    }
    
    @discardableResult
    private func addTapGes()->UITapGestureRecognizer{
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(ASManagerVC.didTapOnBottomView(tapGes:)))
        self.containerView.addGestureRecognizer(tapGes)
        
        self.containerView.gestureRecognizers?.forEach({
            
            if $0 is UITapGestureRecognizer{
                tapGes.require(toFail:$0)
            }
            
        })
        return tapGes
    }
    
    @objc private func didTapOnBottomView(tapGes:UITapGestureRecognizer){
        
        if currentState == .small{
            currentState = .big
            changeToBigDimensions(Animate: true)
        }
        else{
            currentState = .small
            changeToSmallDimensions(Animate: true)
        }
        
    }
    
    @discardableResult
    private func addPanGes()->UIPanGestureRecognizer{
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(ASManagerVC.didPanOnBottomView(panGes:)))
        self.containerView.addGestureRecognizer(panGes)
        return panGes
    }
    
    
    
    @objc private func didPanOnBottomView(panGes:UIPanGestureRecognizer){
        let finalSize = self.finalSize
        if panGes.state == .ended{
            if abs(bottomC.constant) < finalSize.height/2{// half more big
                changeToBigDimensions(Animate: true)
            }
            else {//half less big
                changeToSmallDimensions(Animate: true)
            }
        }
        else{
            let initialSize = self.initialSize
            
            let location = panGes.location(in: self.view)
            let moveYBy = location.y - containerView.frame.origin.y
            let c:CGFloat = moveYBy//(velocity.y/self.view.frame.height)*10
            
            changeDimensionsFor(Desloc: c)
            
            if bottomC.constant > 0{//big
                changeToBigDimensions(Animate: false)
                self.view.layoutIfNeeded()
            }
            else if bottomC.constant < (initialSize.height - finalSize.height){//initial
                changeToSmallDimensions(Animate: false)
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    @discardableResult
    func addUpSwipeGes()->UISwipeGestureRecognizer{
        
        let upSwipeGes = UISwipeGestureRecognizer(target: self, action: #selector(ASManagerVC.didSwipeOnBottomView(swipeGes:)))
        upSwipeGes.direction = .up
        self.containerView.addGestureRecognizer(upSwipeGes)
        
        return upSwipeGes
        
    }
    
    @discardableResult
    func addDownSwipeGes()->UISwipeGestureRecognizer{
        
        let downSwipeGes = UISwipeGestureRecognizer(target: self, action: #selector(ASManagerVC.didSwipeOnBottomView(swipeGes:)))
        downSwipeGes.direction = .down
        self.containerView.addGestureRecognizer(downSwipeGes)
        
        return downSwipeGes
    }
    
    
    @objc func didSwipeOnBottomView(swipeGes:UISwipeGestureRecognizer){
        if swipeGes.direction == .up{
            changeToBigDimensions(Animate: true)
        }
        else{
            changeToSmallDimensions(Animate: true)
        }
    }
}

