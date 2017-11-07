//
//  ASManagerVCVC.swift
//  Learning_InteractiveTransactions
//
//  Created by José Lucas Souza das Chagas on 22/10/17.
//  Copyright © 2017 joselucas. All rights reserved.
//

import UIKit

public class ASViewSegue:UIStoryboardSegue{
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        if let teste = source as? ASManagerVC, teste.mainVCSegueID == identifier{
            teste.prepateContainerView(vc: destination)
        }
    }
    public override func perform() {
        print("asd")
    }
}


public struct ActionSheetViewNotifications{
    static let didChangeState = Notification.Name("didChangeState")
}

open class ASManagerVC: UIViewController,ActionSheetViewManager {
    
    @IBInspectable
    public var mainVCSegueID:String?
    private(set) var containerView:UIView!

    public var currentState: ActionSheetViewState = .small{
        didSet{
            
            asView?.didChangeToState(currentState)
            NotificationCenter.default.post(name: ActionSheetViewNotifications.didChangeState, object: self as ActionSheetViewManager)
        }
    }
    
    public var asViewIsHidden:Bool = false{
        didSet{
            if containerView != nil{
                containerView.isHidden = asViewIsHidden
            }
        }
    }
    
    
    public var delegate:ActionSheetViewDelegate?
    private weak var asView:ActionSheetView?
    
    
    /*
    var bottomC:NSLayoutConstraint!
    var leadingC:NSLayoutConstraint!
    var trailingC:NSLayoutConstraint!
    */
    var initialSize:CGSize {
        return delegate?.initialSize() ?? CGSize(width: self.view.frame.width, height: 60)
    }
    
    var finalSize:CGSize {
        return delegate?.finalSize() ?? CGSize(width: self.view.frame.width, height: self.view.frame.height - 100)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: mainVCSegueID!, sender: nil)
        super.viewWillAppear(animated)
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ActionSheetViewManager methods
    
    public func changeToState(_ state: ActionSheetViewState, Animated animated: Bool) {
        if state == .small{
            changeToSmallDimensions(Animate: animated)
        }
        else{
            changeToBigDimensions(Animate: animated)
        }
    }
    
    //MARK: - ActionSheetView

    fileprivate func prepateContainerView(vc:UIViewController){
        guard let _ = containerView else{
            if let asView = vc as? ActionSheetView{
                asView.controller = self
                self.asView = asView
            }
            
            self.addChildViewController(vc)
            containerView = vc.view
            containerView.frame = CGRect(x:  (self.view.frame.width - self.initialSize.width)/2, y: self.view.frame.height - self.initialSize.height, width: self.initialSize.width, height: self.finalSize.height)
            print(containerView.bounds.width)

            containerView.clipsToBounds = true
            containerView.translatesAutoresizingMaskIntoConstraints = true
            containerView.layer.cornerRadius = 20
            self.view.addSubview(containerView)
            
            addGestures()
            delegate?.bottomVC(vc)
            
            //addConstraints()
            
            asView?.didChangeToState(currentState)
            self.changeToState(currentState, Animated: false)
            return
        }

        delegate?.bottomVC(vc)
        asView?.didChangeToState(currentState)
        self.changeToState(currentState, Animated: false)
    }
    
    
    private func addConstraints(){
        /*
         bottomC = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: initialSize.height - finalSize.height)
         self.view.addConstraint(bottomC)
         
         leadingC = NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
         self.view.addConstraint(leadingC)
         trailingC = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
         self.view.addConstraint(trailingC)
         
         
         let heightC = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: finalSize.height)
         self.containerView.addConstraint(heightC)
         /*
         let widthC = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: initialSize.width)
         self.containerView.addConstraint(width)
         let centerXC = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
         self.view.addConstraint(centerXC)
         */
         containerView.translatesAutoresizingMaskIntoConstraints = true
         */
        
    }
    
    
    //MARK: ActionSheetView animation methods
    
    public func changeToSmallDimensions(Animate animate:Bool,Duration duration:TimeInterval = 0.4){

        let center = self.containerView.center
        let smallMaxYValue = self.view.frame.height + finalSize.height/2 - initialSize.height
        
        self.asView?.constraintChangesFor(NewState: .small)
        if animate{
            let startWidth = self.containerView.bounds.width
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions.beginFromCurrentState, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                    self.asView?.apperanceChangesFor(NewState: .small)
                    self.containerView.layoutIfNeeded()
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                    self.containerView.center = CGPoint(x: center.x, y: smallMaxYValue)

                    let scaleTransf = CGAffineTransform(scaleX: self.initialSize.width/startWidth, y: 1)
                    self.containerView.transform = scaleTransf
                })
                
            }) { (finished) in
                self.currentState = .small
            }
        }
        else{
            asView?.apperanceChangesFor(NewState: .small)
            self.containerView.layoutIfNeeded()

            self.containerView.center = CGPoint(x: center.x, y: smallMaxYValue)
            let scaleTransf = CGAffineTransform(scaleX: self.initialSize.width/self.containerView.bounds.width, y: 1)
            self.containerView.transform = scaleTransf

            self.currentState = .small
        }
    }
    
    public func changeToBigDimensions(Animate animate:Bool,Duration duration:TimeInterval = 0.4){
        let center = self.containerView.center
        let bigMaxYValue = self.view.frame.height - finalSize.height/2
        
        self.asView?.constraintChangesFor(NewState: .big)
        if animate{
            let startWidth = self.containerView.bounds.width
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions.beginFromCurrentState, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                    self.asView?.apperanceChangesFor(NewState: .big)
                    self.containerView.layoutIfNeeded()
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                    self.containerView.center = CGPoint(x: center.x, y: bigMaxYValue)
                    let scaleTransf = CGAffineTransform(scaleX: self.finalSize.width/startWidth, y: 1)
                    self.containerView.transform = scaleTransf

                })

            }) { (finished) in
                self.currentState = .big
            }
        }
        else{
            self.asView?.apperanceChangesFor(NewState: .big)
            self.containerView.layoutIfNeeded()

            self.containerView.center = CGPoint(x: center.x, y: bigMaxYValue)
            let scaleTransf = CGAffineTransform(scaleX: self.finalSize.width/self.containerView.bounds.width, y: 1)
            self.containerView.transform = scaleTransf
            
            self.currentState = .big
        }
    }
    
    
    
    
    
    //not updated
    
    public func changeDimensionsFor(Desloc d:CGFloat){
        let initialSize = self.initialSize
        let finalSize = self.finalSize
        
        let currentCenter = self.containerView.center
        var newCenterY = currentCenter.y + d
        
        //check if it possible
        let bigMaxYValue = self.view.frame.height - finalSize.height/2
        let smallMaxYValue = self.view.frame.height + finalSize.height/2 - initialSize.height
        
        if newCenterY < bigMaxYValue{
            self.containerView.center = CGPoint(x: currentCenter.x, y: bigMaxYValue)
            newCenterY = bigMaxYValue
        }
        else if newCenterY > smallMaxYValue{
            self.containerView.center = CGPoint(x: currentCenter.x, y: smallMaxYValue)
            newCenterY = smallMaxYValue
        }
        else{//range valido
            self.containerView.center = CGPoint(x: currentCenter.x, y: newCenterY)
        }
        
        let desly_100 = smallMaxYValue - bigMaxYValue
        let currentDesly = smallMaxYValue - newCenterY
        let progress = currentDesly/desly_100
        
        let deslx_100 = self.finalSize.width - self.initialSize.width
        let widthIncrement = currentState == .big ? deslx_100*(1 - progress)  : (deslx_100)*progress
        let base = currentState == .big ? self.finalSize.width : self.initialSize.width
        let newWidth = currentState == .big ? base - widthIncrement : base + widthIncrement
        
        let scaleX = newWidth/self.containerView.bounds.width
        
        let scaleTransf = CGAffineTransform(scaleX: scaleX, y: 1)
        self.containerView.transform = scaleTransf
        
        self.asView?.uiChangesFor(Progress: progress, BigStateProgress: 1, SmallStateProgress: 0)
        
        let newState:ActionSheetViewState = (newCenterY == bigMaxYValue ? .big : .small)
        if newState != self.currentState{
            self.currentState = newState
        }
    }

}
