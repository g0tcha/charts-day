//
//  FeedingHistoryPageViewController.swift
//  FeedingHistoryLab
//
//  Created by vincent on 16/09/2016.
//  Copyright © 2016 infostrates. All rights reserved.
//

import UIKit

class FeedingHistoryPageViewController: UIPageViewController {
    
    enum viewControllerType {
        case specific
        case all
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(type: .specific), self.newViewController(type: .specific), self.newViewController(type: .all)]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func newViewController(type: viewControllerType) -> UIViewController {
        switch type {
        case .specific:
            return storyboard?.instantiateViewController(withIdentifier: "SpecificBowlHistoryView") as! SpecificBowlHistoryViewController
        case .all:
            return storyboard?.instantiateViewController(withIdentifier: "AllBowlHistoryView") as! AllBowlHistoryViewController
        }
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension FeedingHistoryPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}


