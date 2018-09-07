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
        addPanGes()
        //let upSwipe = addUpSwipeGes()
        //let downSwipe = addDownSwipeGes()
        //pan.require(toFail: upSwipe)
        //pan.require(toFail: downSwipe)
    }
    
    @discardableResult
    private func addTapGes()->UITapGestureRecognizer{
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(ASManagerVC.didTapOnASView(tapGes:)))
        
        self.view.addGestureRecognizer(tapGes)
        
        return tapGes
    }
    
    @objc private func didTapOnASView(tapGes:UITapGestureRecognizer){
        let location = tapGes.location(in: self.view)
        guard let containerView = self.containerView else{return}
        let isInsideASView = containerView.frame.contains(location)
        
        if currentState == .small && isInsideASView{
            currentState = .big
            changeToBigDimensions(Animate: true)
        }
        else if currentState != .small && !isInsideASView{
            currentState = .small
            changeToSmallDimensions(Animate: true)
        }
        
    }
    
    
    //MARK: - Swipe Gesture
    
    
    @discardableResult
    func addUpSwipeGes()->UISwipeGestureRecognizer{
        
        let upSwipeGes = UISwipeGestureRecognizer(target: self, action: #selector(ASManagerVC.didSwipeOnASView(swipeGes:)))
        upSwipeGes.direction = .up
        self.containerView?.addGestureRecognizer(upSwipeGes)
        
        return upSwipeGes
        
    }
    
    @discardableResult
    func addDownSwipeGes()->UISwipeGestureRecognizer{
        
        let downSwipeGes = UISwipeGestureRecognizer(target: self, action: #selector(ASManagerVC.didSwipeOnASView(swipeGes:)))
        downSwipeGes.direction = .down
        self.containerView?.addGestureRecognizer(downSwipeGes)
        
        return downSwipeGes
    }
    
    
    @objc func didSwipeOnASView(swipeGes:UISwipeGestureRecognizer){
        if swipeGes.direction == .up{
            changeToBigDimensions(Animate: true)
        }
        else{
            changeToSmallDimensions(Animate: true)
        }
    }
}

