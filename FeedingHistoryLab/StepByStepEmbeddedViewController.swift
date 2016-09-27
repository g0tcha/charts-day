//
//  StepByStepEmbeddedViewController.swift
//  FeedingHistoryLab
//
//  Created by vincent on 19/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import UIKit

class StepByStepEmbeddedViewController: UITableViewController {
    enum identifiers: String {
        case cell = "FeedingHistoryCell"
    }
    
    let items = HistoryItemStore.getHistoryItems()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers.cell.rawValue, for: indexPath) as! FeedingTableViewCell
        
        let item = items[indexPath.row]
        
        cell.timeLabel.text = item.hour
        cell.typeLabel.text = item.type
        cell.quantityLabel.text = item.quantity
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
