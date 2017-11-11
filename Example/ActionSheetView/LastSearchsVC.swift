//
//  LastSearchsVC.swift
//  Learning_InteractiveTransactions
//
//  Created by José Lucas Souza das Chagas on 27/10/17.
//  Copyright © 2017 joselucas. All rights reserved.
//

import UIKit
import ActionSheetView

class LastSearchsVC: UIViewController,ActionSheetView,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resultsTV: UITableView!
    
    var controller: ActionSheetViewManager?
    
    @IBOutlet weak var searchTopDistC: NSLayoutConstraint!
    
    @IBOutlet weak var barTopDist: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setUpTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if controller?.currentState != .big{
            controller?.changeToState(.big, Animated: true)
        }
    }
    
    //MARK: - ActionSheetView methods
    
    func didChangeToState(_ state: ActionSheetViewState) {
        if state == .small{
            self.searchBar.resignFirstResponder()
        }
    }
    
    func apperanceChangesFor(NewState state: ActionSheetViewState) {
        if state == .small{
            self.view.layer.cornerRadius = 15
            self.titleLabel.alpha = 0
        }
        else{
            self.view.layer.cornerRadius = 0
            self.titleLabel.alpha = 1
        }
    }
    
    func constraintChangesFor(NewState state: ActionSheetViewState) {
        if state == .small{
            searchTopDistC.constant = -21
            barTopDist.constant = 20
        }
        else{
            searchTopDistC.constant = 35
            barTopDist.constant = 4
        }
    }
    
    func uiChangesFor(Progress quant: CGFloat, BigStateProgress big: CGFloat, SmallStateProgress small: CGFloat) {
        self.view.layer.cornerRadius = 15 - 15*quant
        self.titleLabel.alpha = quant
        
        searchTopDistC.constant = 56*quant - 21
        barTopDist.constant = 24 - 20*quant
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Table view methods
    
    private func setUpTableView(){
        self.resultsTV.delegate = self
        self.resultsTV.dataSource = self
    }
    
    
    
}
