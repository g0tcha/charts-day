//
//  SpecificBowlHistoryViewController.swift
//  FeedingHistoryLab
//
//  Created by vincent on 16/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import UIKit

protocol SpecificBowlHistoryViewControllerDelegate {
    func specificBowlHistoryViewControllerDidSelectEnvironmentalValue()
}

class SpecificBowlHistoryViewController: UIViewController {
    
    // MARK: - Properties
    var delegate: SpecificBowlHistoryViewControllerDelegate?
    var chartViewController: ChartViewController!
    
    // MARK: - Enums
    enum segueIdentifier: String {
        case timeLine = "TimeLineHourSegue"
        case chart = "ChartSegue"
    }
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var dataEnvironmentScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mainScrollView.contentSize = CGSize(width: view.bounds.size.width, height: 800)
        mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0)
        
        dataEnvironmentScrollView.contentSize = CGSize(width: view.bounds.size.width * 2, height: dataEnvironmentScrollView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier.chart.rawValue {
            let controller = segue.destination as! ChartViewController
            chartViewController = controller
        }
    }

    @IBAction func environmentDataTapped(_ sender: AnyObject) {
        chartViewController.addEnvironmentData()
    }
}
