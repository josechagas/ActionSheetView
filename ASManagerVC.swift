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
            
            bottomView?.didChangeToState(currentState)
            NotificationCenter.default.post(name: ActionSheetViewNotifications.didChangeState, object: self as ActionSheetViewManager)
        }
    }
    
    public var delegate:ActionSheetViewDelegate?
    public weak var bottomView:ActionSheetView?
    
    
    var bottomC:NSLayoutConstraint!
    fileprivate var leadingC:NSLayoutConstraint!
    fileprivate var trailingC:NSLayoutConstraint!
    
    
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
    
    //MARK: - BottomViewManager methods
    
    public func changeToState(_ state: ActionSheetViewState, Animated animated: Bool) {
        if state == .small{
            changeToSmallDimensions(Animate: animated)
        }
        else{
            changeToBigDimensions(Animate: animated)
        }
    }
    
    //MARK: - BottomView

    fileprivate func prepateContainerView(vc:UIViewController){
        
        if let bottomView = vc as? ActionSheetView{
            bottomView.controller = self
            self.bottomView = bottomView
        }
        
        self.addChildViewController(vc)
        containerView = vc.view
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(containerView)
        let initialSize = self.initialSize
        let finalSize = self.finalSize
        
        addGestures()
        delegate?.bottomVC(vc)
        
        bottomC = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: initialSize.height - finalSize.height)
        self.view.addConstraint(bottomC)

        leadingC = NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: (finalSize.width - initialSize.width)/2)
        self.view.addConstraint(leadingC)
        trailingC = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: (finalSize.width - initialSize.width)/2)
        self.view.addConstraint(trailingC)
        
        
        let heightC = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: finalSize.height)
        self.containerView.addConstraint(heightC)

        bottomView?.didChangeToState(currentState)
        bottomView?.apperanceChangesFor(NewState: currentState)
        bottomView?.constraintChangesFor(NewState: currentState)
    }
    
    public func changeToSmallDimensions(Animate animate:Bool){
        let initialSize = self.initialSize
        let finalSize = self.finalSize

        bottomC.constant = initialSize.height - finalSize.height
        leadingC.constant = (finalSize.width - initialSize.width)/2
        trailingC.constant = (finalSize.width - initialSize.width)/2
        
        bottomView?.constraintChangesFor(NewState: .small)
        if animate{
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.bottomView?.apperanceChangesFor(NewState: .small)
                self.view.layoutIfNeeded()
            }) { (finished) in
                self.currentState = .small
            }
        }
    }
    
    public func changeToBigDimensions(Animate animate:Bool){
        let finalSize = self.finalSize

        bottomC.constant = 0
        leadingC.constant = (finalSize.width - self.view.frame.width)/2
        trailingC.constant = (finalSize.width - self.view.frame.width)/2
        
        bottomView?.constraintChangesFor(NewState: .big)
        if animate{
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.bottomView?.apperanceChangesFor(NewState: .big)
                self.view.layoutIfNeeded()
            }) { (finished) in
                self.currentState = .big
            }
        }
    }
    
    public func changeDimensionsFor(Desloc d:CGFloat){
        let initialSize = self.initialSize
        let finalSize = self.finalSize
        
        bottomC.constant -= d
        let progress = (finalSize.height + bottomC.constant)/(finalSize.height)
        
        let max = (finalSize.width - initialSize.width)/2
        let value = max - max*progress
        leadingC.constant = value
        trailingC.constant = value
        
    
        bottomView?.uiChangesFor(Progress: progress, BigStateProgress: 1, SmallStateProgress: 0)
        let newState:ActionSheetViewState = (self.bottomC.constant == CGFloat(0) ? .big : .small)
        if newState != self.currentState{
            self.currentState = newState
        }
    }

}
