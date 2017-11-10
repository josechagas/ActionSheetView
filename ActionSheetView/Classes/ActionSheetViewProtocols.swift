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
    
}

/**
 Sera necessario a adicao de alguns metodos para quando o usuario esta mudando o estado da tela usando o pan gesture
 */
public protocol ActionSheetView:class where Self: UIViewController {
    var controller:ActionSheetViewManager?{get set}
    
    /**
     Execute some configuration for each state
     */
    func didChangeToState(_ state:ActionSheetViewState)
    
    /**
     Add UI(colors, layer things ...) Changes on this method, they will be automatically animated
     */
    func apperanceChangesFor(NewState state:ActionSheetViewState)
    
    /**
     Add constraint changes on this method, they will be automatically animated
     */
    func constraintChangesFor(NewState state:ActionSheetViewState)
    
    /**
     Add UI(colors, layer things ...) and constraint change on this method, the new values of changed properties must be relative to progress.
     This method is called on specific case of Pan Gesture being execute by user
     */
    func uiChangesFor(Progress quant:CGFloat, BigStateProgress big:CGFloat, SmallStateProgress small:CGFloat)
}

public protocol ActionSheetViewManager{
    var currentState:ActionSheetViewState{get}
    func changeToState(_ state:ActionSheetViewState,Animated animated:Bool)
}

public enum ActionSheetViewState:String{
    case small = "small"
    case big = "big"
}
