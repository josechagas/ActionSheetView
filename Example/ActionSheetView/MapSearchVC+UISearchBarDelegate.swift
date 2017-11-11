//
//  MapSearchVC+UISearchBarDelegate.swift
//  ActionSheetView_Example
//
//  Created by José Lucas Souza das Chagas on 11/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit


extension MapSearchVC:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if controller?.currentState != .big{
            controller?.changeToState(.big, Animated: true)
        }
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text{
            searchResults = []
            self.resultsTV.reloadData()
            showBackLoadingView()
            MKLocalSearchHelper.newSearchFor(Text: text, completion: { (success, items) in
                if success{
                    self.searchResults = items ?? []
                    self.resultsQuantLabel.text = "\(self.searchResults.count) Results"
                    self.resultsTV.reloadData()
                }
                else{
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    let alertC = UIAlertController(title: "ERROR", message: "It was not possible to complete your search", preferredStyle: .alert)
                    alertC.addAction(okAction)
                    self.present(alertC, animated: true, completion: nil)
                }
                
                self.resultsQuantLabel.text = "\(self.searchResults.count) Results"
                self.showCorrespondingBackView()

                searchBar.resignFirstResponder()
                print("returned")
            })
        }
        else{
            self.resultsTV.reloadData()
        }
        searchBar.resignFirstResponder()

    }
    
}
