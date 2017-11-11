//
//  MapSearchVC+UITableViewDelegate+DataSource.swift
//  ActionSheetView_Example
//
//  Created by José Lucas Souza das Chagas on 11/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//


import UIKit

private struct MapSearchVCTVCellsIDs{
    static let resultCell = "resultCell"
}

extension MapSearchVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchResults.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MapSearchVCTVCellsIDs.resultCell)!
        
        let item = searchResults[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.placemark.title
        
        return cell
    }
}

extension MapSearchVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = searchResults[indexPath.row]
        self.controller?.changeToState(.small, Animated: true)
        showOnMap?(item)
    }
}

