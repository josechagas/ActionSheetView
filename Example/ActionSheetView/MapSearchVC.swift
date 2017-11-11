//
//  MapSearchVC.swift
//  ActionSheetView_Example
//
//  Created by José Lucas Souza das Chagas on 11/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ActionSheetView
import MapKit
class MapSearchVC: UIViewController,ActionSheetView {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultsQuantLabel: UILabel!
    @IBOutlet weak var resultsTV: UITableView!
    
    @IBOutlet weak var searchTopDistC: NSLayoutConstraint!
    @IBOutlet weak var barTopDist: NSLayoutConstraint!
    
    
    var controller: ActionSheetViewManager?
    var showOnMap:((_ item:MKMapItem)->Void)?
    
    var searchResults:[MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsQuantLabel.text = ""
        searchBar.delegate = self
        setUpTableView()
        
        showInfoView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.resultsTV.tableFooterView = UIView()
    }
    
    func showCorrespondingBackView(){
        if searchResults.count == 0 {
            showInfoView()
        }
        else{
            hideBackView()
        }
    }
    
    func showBackLoadingView(){
        let backView = TableViewBackLV.fromXib()
        backView.setUpWith(title: "Search", info: "Looking for Results...", buttonTitle: nil, buttonAction: nil)
        resultsTV.backgroundView = backView
        backView.startLoadingAnimation()
    }
    
    func showInfoView(){
        let infoView = NoDataView.fromXib()
        infoView.setUpWith(message: "No Search Results Here", showActionButton: false)
        resultsTV.backgroundView = infoView
    }
    
    func hideBackView(){
        self.resultsTV.backgroundView = nil
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

}
