//
//  NoDataView.swift
//  Pizza Day
//
//  Created by José Lucas Souza das Chagas on 17/03/17.
//  Copyright © 2017 José Lucas Souza das Chagas. All rights reserved.
//

import UIKit

public class NoDataView: UIView {

    @IBOutlet weak public var messageLabel: UILabel!
    
    @IBOutlet weak public var actionButton: UIButton!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var buttonAction:((_ button:UIButton)->())?
    
    public class func fromXib()->NoDataView{
        let bundle = Bundle(for: NoDataView.classForCoder())
        return bundle.loadNibNamed("NoDataView", owner: self, options: nil)![0] as! NoDataView
    }
    
    public func setUpWith(message:String,showActionButton:Bool){
        messageLabel.text = message
        actionButton.isHidden = !showActionButton
        actionButton.isEnabled = showActionButton
    }

    public func buttonAction(action:@escaping (_ button:UIButton)->()){
        buttonAction = action
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        
        buttonAction!(sender as! UIButton)
    
    }

}
