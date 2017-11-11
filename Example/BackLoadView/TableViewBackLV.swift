//
//  TableViewBackLV.swift
//  Pizza Day
//
//  Created by José Lucas Souza das Chagas on 12/05/17.
//  Copyright © 2017 José Lucas Souza das Chagas. All rights reserved.
//

import UIKit
import Shimmer

public class TableViewBackLV: UIView {
    @IBOutlet weak var content: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    @IBOutlet weak var shimmerView: FBShimmeringView!
    
    private var buttonAction:(()->())?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public class func fromXib()->TableViewBackLV{
        let bundle = Bundle(for: TableViewBackLV.classForCoder())
        return bundle.loadNibNamed("TableVBackLoadingView", owner: self, options: nil)![0] as! TableViewBackLV
    }

    
    
    public func setUpWith(title:String,info:String,buttonTitle:String?,buttonAction:(()->())?){
        
        self.alpha = 0
        
        titleLabel.text = title
        infoLabel.text = info
        
        if let buttonTitle = buttonTitle{
            actionButton.isHidden = false

            actionButton.setTitle(buttonTitle, for: .normal)
            
            self.buttonAction = buttonAction
        }
        else{
            actionButton.isHidden = true
        }
    }

    
    
    public func appearAnimation(){
        
        UIView.animate(withDuration: 0.4) { 
            self.alpha = 1
        }
        
    }
    
    public func startLoadingAnimation(){
        appearAnimation()
        
        shimmerView.contentView = content
        
        shimmerView.shimmeringAnimationOpacity = 0.3
        
        shimmerView.shimmeringPauseDuration = 0.2
        
        shimmerView.isShimmering = true
    }
    
    public func stopLoadingAnimation(){
        shimmerView.isShimmering = false
    }
    
    @IBAction func actionButtonAction(_ sender: UIButton) {
        if let action = buttonAction{
            action()
        }
    }
}
