//
//  ViewController.swift
//  Learning_InteractiveTransactions
//
//  Created by José Lucas Souza das Chagas on 22/10/17.
//  Copyright © 2017 joselucas. All rights reserved.
//

import UIKit
import ActionSheetView

class ViewController: ASManagerVC,ActionSheetViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        asViewIsHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hideASViewBtnAction(_ sender: Any) {
        self.asViewIsHidden = true
    }
    
    
    @IBAction func showASViewAction(_ sender: Any) {
        self.asViewIsHidden = false
    }
    
    
    
    func initialSize() -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: 130)
    }
    
    func finalSize() -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 100)
    }

    func bottomVC(_ vc: UIViewController) {
        //vc.view.layer.cornerRadius = 15
    }
    
}

