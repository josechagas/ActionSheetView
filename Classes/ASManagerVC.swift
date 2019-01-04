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
        if let teste = source as? ASManagerVC, teste.ActionSheetVCSegueID == identifier{
            teste.prepareContainerView(vc: destination)
            
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
    open var ActionSheetVCSegueID:String?

    private var darkLayer:CALayer?
    private(set) var containerView:UIView?{
        didSet{
            tryToAddDarkLayer()
        }
    }

    public var currentState: ActionSheetViewState = .small{
        didSet{
            updateSubViewsInterations()
            asView?.didChangeToState(currentState)
            NotificationCenter.default.post(name: ActionSheetViewNotifications.didChangeState, object: self as ActionSheetViewManager)
        }
    }
    
    @IBInspectable
    public var asViewIsHidden:Bool = false{
        didSet{
            containerView?.isHidden = asViewIsHidden
        }
    }
    
    
    public var delegate:ActionSheetViewDelegate?{
        didSet{
            tryToAddDarkLayer()
        }

    }
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
        self.performSegue(withIdentifier: ActionSheetVCSegueID!, sender: nil)
        tryToAddDarkLayer()
        super.viewWillAppear(animated)
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     This method enable or disable user interaction with some subviews accordingly to currenState and delegate options
     */
    private func updateSubViewsInterations(){
        if let d = delegate{
            if d.showDarkBackgroundLayer(){
                self.view.subviews.forEach({ (v) in
                    if !v.isEqual(self.containerView){
                        v.isUserInteractionEnabled = (currentState == .small)
                    }
                })
                return
            }
        }
        
        self.view.subviews.forEach({ (v) in
            if !v.isEqual(self.containerView){
                v.isUserInteractionEnabled = true
            }
        })
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
    
    public func reloadActionSheetView(){
        
        if let asVC = self.children.first(where: {$0 is ActionSheetView}){
            self.delegate?.bottomVC(asVC)
        }
        self.containerView?.frame.size.height = self.finalSize.height
        tryToAddDarkLayer()
        asView?.didChangeToState(currentState)
        self.changeToState(currentState, Animated: true)
        
    }

    //MARK: - DarkLayer
    
    fileprivate func tryToAddDarkLayer(){
        if let d = delegate{
            if  d.showDarkBackgroundLayer(){
                self.addDarkLayer()
            }
            else{
                self.darkLayer?.removeFromSuperlayer()
                self.darkLayer = nil
            }
        }
    }
    
    fileprivate func addDarkLayer(){
        guard let _ = darkLayer else{
            if let containerView = containerView {
                darkLayer = CALayer()
                darkLayer?.backgroundColor = UIColor.black.cgColor
                darkLayer?.frame = CGRect(x: -10, y: -10, width: self.view.frame.width + 20, height: self.view.frame.height + 20)
                self.view.layer.insertSublayer(darkLayer!, below: containerView.layer)
                darkLayerSmall()
            }
            return
        }
        darkLayerSmall()
    }

    private func darkLayerFor(Progress progress:CGFloat){
        let max = delegate?.darkLayerOpacityForState(.big) ?? 0.4
        let min = delegate?.darkLayerOpacityForState(.small) ?? 0
        self.darkLayer?.opacity = min + Float(progress)*(max - min)
    }
    
    private func darkLayerSmall(){
        self.darkLayer?.opacity = delegate?.darkLayerOpacityForState(.small) ?? 0
    }
    
    private func darkLayerBig(){
        self.darkLayer?.opacity = delegate?.darkLayerOpacityForState(.big) ?? 0.4
    }
    
    //MARK: - ActionSheetView

    fileprivate func prepareContainerView(vc:UIViewController){
        guard let _ = containerView else{
            if let asView = vc as? ActionSheetView{
                asView.controller = self
                self.asView = asView
            }
            
            self.addChild(vc)
            containerView = vc.view
            guard let cv = containerView else{return}
            
            cv.frame = CGRect(x:  (self.view.frame.width - self.initialSize.width)/2, y: self.view.frame.height - self.initialSize.height, width: self.initialSize.width, height: self.finalSize.height)
            print(cv.bounds.width)

            cv.translatesAutoresizingMaskIntoConstraints = true
            
            self.view.addSubview(cv)
            
            addGestures()
            
            delegate?.bottomVC(vc)
            asView?.didChangeToState(currentState)
            self.changeToState(currentState, Animated: false)
            return
        }

        asView?.didChangeToState(currentState)
        self.changeToState(currentState, Animated: false)
        
    }
    

    
    //MARK: ActionSheetView animation methods
    
    public func changeToSmallDimensions(Animate animate:Bool,Duration duration:TimeInterval = 0.4){
        guard let containerView = self.containerView else{return}
        let center = containerView.center
        let smallMaxYValue = self.view.frame.height + finalSize.height/2 - initialSize.height
        
        self.asView?.constraintChangesFor(NewState: .small)
        if animate{

            let startWidth = containerView.bounds.width
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIView.KeyframeAnimationOptions.beginFromCurrentState, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                    self.asView?.apperanceChangesFor(NewState: .small)
                    containerView.layoutIfNeeded()
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                    self.darkLayerSmall()
                    containerView.center = CGPoint(x: center.x, y: smallMaxYValue)
                    let scaleTransf = CGAffineTransform(scaleX: self.initialSize.width/startWidth, y: 1)
                    containerView.transform = scaleTransf
                    //self.containerView.bounds.size = CGSize(width: self.initialSize.width, height: self.containerView.bounds.size.height)
                    
                })
                
            }) { (finished) in
                self.currentState = .small
            }
        }
        else{
            asView?.apperanceChangesFor(NewState: .small)
            containerView.layoutIfNeeded()

            self.darkLayerSmall()
            containerView.center = CGPoint(x: center.x, y: smallMaxYValue)
            
            let scaleTransf = CGAffineTransform(scaleX: self.initialSize.width/containerView.bounds.width, y: 1)
            containerView.transform = scaleTransf
            //self.containerView.bounds.size = CGSize(width: self.initialSize.width, height: self.containerView.bounds.size.height)
            
            self.currentState = .small
        }
    }
    
    public func changeToBigDimensions(Animate animate:Bool,Duration duration:TimeInterval = 0.4){
        guard let containerView = self.containerView else{return}

        let center = containerView.center
        let bigMaxYValue = self.view.frame.height - finalSize.height/2
        
        self.asView?.constraintChangesFor(NewState: .big)
        
        if animate{
            let startWidth = containerView.bounds.width
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIView.KeyframeAnimationOptions.beginFromCurrentState, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                    self.asView?.apperanceChangesFor(NewState: .big)
                    containerView.layoutIfNeeded()
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                    self.darkLayerBig()
                    containerView.center = CGPoint(x: center.x, y: bigMaxYValue)
                    
                    let scaleTransf = CGAffineTransform(scaleX: self.finalSize.width/startWidth, y: 1)
                    containerView.transform = scaleTransf
                    //self.containerView.bounds.size = CGSize(width: self.finalSize.width, height: self.containerView.bounds.size.height)
                })

            }) { (finished) in
                self.currentState = .big
            }
        }
        else{
            
            self.asView?.apperanceChangesFor(NewState: .big)
            containerView.layoutIfNeeded()

            self.darkLayerBig()
            containerView.center = CGPoint(x: center.x, y: bigMaxYValue)
            
            let scaleTransf = CGAffineTransform(scaleX: self.finalSize.width/containerView.bounds.width, y: 1)
            containerView.transform = scaleTransf
            //self.containerView.bounds.size = CGSize(width: self.finalSize.width, height: self.containerView.bounds.size.height)
            
            self.currentState = .big
        }
    }
    
    
    
    
    
    //not updated
    
    public func changeDimensionsFor(Desloc d:CGFloat){
        guard let containerView = self.containerView else{return}
        
        let initialSize = self.initialSize
        let finalSize = self.finalSize
        
        let currentCenter = containerView.center
        var newCenterY = currentCenter.y + d
        
        //check if it possible
        let bigMaxYValue = self.view.frame.height - finalSize.height/2
        let smallMaxYValue = self.view.frame.height + finalSize.height/2 - initialSize.height
        
        if newCenterY < bigMaxYValue{
            containerView.center = CGPoint(x: currentCenter.x, y: bigMaxYValue)
            newCenterY = bigMaxYValue
        }
        else if newCenterY > smallMaxYValue{
            containerView.center = CGPoint(x: currentCenter.x, y: smallMaxYValue)
            newCenterY = smallMaxYValue
        }
        else{//range valido
            containerView.center = CGPoint(x: currentCenter.x, y: newCenterY)
        }
        
        let desly_100 = smallMaxYValue - bigMaxYValue
        let currentDesly = smallMaxYValue - newCenterY
        let progress = currentDesly/desly_100
        
        let deslx_100 = self.finalSize.width - self.initialSize.width
        let widthIncrement = currentState == .big ? deslx_100*(1 - progress)  : (deslx_100)*progress
        let base = currentState == .big ? self.finalSize.width : self.initialSize.width
        let newWidth = currentState == .big ? base - widthIncrement : base + widthIncrement
        
        let scaleX = newWidth/containerView.bounds.width
        
        let scaleTransf = CGAffineTransform(scaleX: scaleX, y: 1)
        containerView.transform = scaleTransf
        
        self.asView?.uiChangesFor(Progress: progress, BigStateProgress: progress, SmallStateProgress: 1 - progress)
        
        
        if delegate?.showDarkBackgroundLayer() ?? false{
            darkLayerFor(Progress: progress)
        }
        
        let newState:ActionSheetViewState = (newCenterY == bigMaxYValue ? .big : .small)
        if newState != self.currentState{
            self.currentState = newState
        }
    }

}
