//
//  LastSearchsVC+UITableViewDataSource+Delega.swift
//  Learning_InteractiveTransactions
//
//  Created by José Lucas Souza das Chagas on 28/10/17.
//  Copyright © 2017 joselucas. All rights reserved.
//

import UIKit

private struct LastSearchsVCTVCellsIDs{
    static let resultCell = "resultCell"
}

extension LastSearchsVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LastSearchsVCTVCellsIDs.resultCell)!
        cell.textLabel?.text = "Result \(indexPath.row)"
        cell.detailTextLabel?.text = "some description"
        
        return cell
    }
}

extension LastSearchsVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("clicked")
    }
}
