//
//  BottomViewProtocols.swift
//  Learning_InteractiveTransactions
//
//  Created by José Lucas Souza das Chagas on 27/10/17.
//  Copyright © 2017 joselucas. All rights reserved.
//

import UIKit


public protocol ActionSheetViewDelegate{
    /**
     Use this method to pass some data to your bottom vc, perform some customizatinos, for example add new gestures.
     */
    func bottomVC(_ vc:UIViewController)
    /**
     Inform the initial size of your ActionSheetView, this is the size for ActionSheetViewState.small
     */
    func initialSize()->CGSize
    /**
     Inform the final size of your ActionSheetView, this is the size for ActionSheetViewState.big
     */
    func finalSize()->CGSize
    /**
     This method determine if a dark layer should be presented or not depending of ActionSheetViewState of your ActionSheetView instance.
     - returns: false to not present or true to present
     
     The default implementation returns always true
     */
    func showDarkBackgroundLayer()->Bool
    /**
     Implement this method to indicate dark layer opacity depending of ActionSheetView state.
     - parameter state: Current state of your ActionSheetView.
     - returns: Float value from 0 to 1 indicating dark layer opacity.
     
     The default implementation returns 0.45 when its on ActionSheetViewState.big and 0 on ActionSheetViewState.small.
     */
    func darkLayerOpacityForState(_ state:ActionSheetViewState)->Float
}

public extension ActionSheetViewDelegate{
    func showDarkBackgroundLayer()->Bool{
        return true
    }
    
    func darkLayerOpacityForState(_ state:ActionSheetViewState)->Float{
        return state == .big ? 0.45 : 0
    }
}

/**
 Sera necessario a adicao de alguns metodos para quando o usuario esta mudando o estado da tela usando o pan gesture
 */
public protocol ActionSheetView:class {
    var controller:ActionSheetViewManager?{get set}
    
    /**
     Execute some configuration, which should not for each state
     - parameter state: New state of ActionSheetView
     */
    func didChangeToState(_ state:ActionSheetViewState)
    
    /**
     Add UI(colors, layer things ...) Changes on this method, they will be automatically animated
     This method will called everytime user changes its state(ActionSheetViewState) animated or not
     
     - parameter state: New state of ActionSheetView
     */
    func apperanceChangesFor(NewState state:ActionSheetViewState)
    
    /**
     Add constraint changes on this method, they will be automatically animated
     This method will called everytime user changes its state(ActionSheetViewState) animated or not
     
     - parameter state: New state of ActionSheetView
     */
    func constraintChangesFor(NewState state:ActionSheetViewState)
    
    /**
     Add UI(colors, layer things ...) and constraint change on this method, the new values of changed properties must be relative to progress.
     This method is called on specific case of Pan Gesture being execute by user.
     
     
     Normally this method does what 'constraintChangesFor' and 'apperanceChangesFor' do on your implementation with a difference that the changes are controlled by the current progress of gesture
     
     */
    func uiChangesFor(Progress quant:CGFloat, BigStateProgress big:CGFloat, SmallStateProgress small:CGFloat)
}

public protocol ActionSheetViewManager{
    /**
     Current state of your ActionSheetView.
     */
    var currentState:ActionSheetViewState{get}
    /**
     Call this method to change your ActionSheetView instace state to ActionSheetViewState.small or ActionSheetViewState.big
     - parameter state: the new state of your ActionSheetView instance.
     - parameter animated: true to animate the state change and false to perform update immediately.
     */
    func changeToState(_ state:ActionSheetViewState,Animated animated:Bool)
    /**
     This method reloads the ActionSheetView, calling some 'ActionSheetViewDelegate' and ActionSheetView methods to update the view
     */
    func reloadActionSheetView()
}

public enum ActionSheetViewState:String{
    case small = "small"
    case big = "big"
}
