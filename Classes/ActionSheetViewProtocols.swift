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
     Use this method to pass some data to your bottom vc
     */
    func bottomVC(_ vc:UIViewController)
    
    func initialSize()->CGSize
    func finalSize()->CGSize
    
    func showDarkBackgroundLayer()->Bool
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
    var currentState:ActionSheetViewState{get}
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
