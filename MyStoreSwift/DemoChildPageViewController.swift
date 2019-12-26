//
//  DemoChildPageViewController.swift
//  HXPageViewController
//
//  Created by HongXiangWen on 2019/1/11.
//  Copyright © 2019年 WHX. All rights reserved.
//

import UIKit

class DemoChildPageViewController: UIViewController {
    
    private var titles = ["ホーム"]
    private var collections : [CollectionViewModel] = []
    var activityIndicator: UIActivityIndicatorView!
    

    
    private lazy var pageVC: HXPageViewController = {
        let pageVC = HXPageViewController()
        pageVC.dataSource = self
        pageVC.delegate = self
        return pageVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        // クルクルをストップした時に非表示する
        activityIndicator.hidesWhenStopped = true
        // 色を設定
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        getTitles()
        addChild(pageVC)
        pageVC.didMove(toParent: pageVC)
        view.addSubview(pageVC.view)
    }
    

    
    
    override func viewDidAppear(_ animated: Bool) {
        self.reloadInputViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let originY = UIApplication.shared.statusBarFrame.height + 44
        pageVC.view.frame = CGRect(x: 0, y: originY, width: view.bounds.width, height: view.bounds.height - originY)
    }
    
    func getTitles(after cursor: String? = nil) {
        Client.shared.fetchCollections(after: cursor) { collections in
            if let collections = collections {
                for var collectionTitle in collections.items{
                    self.collections.append(collectionTitle)
                    self.titles.append(collectionTitle.title)
                }
            }
        }
    }
}

// MARK: -  HXPageViewControllerDelegate, HXPageViewControllerDataSource
extension DemoChildPageViewController: HXPageViewControllerDelegate, HXPageViewControllerDataSource {
    
    func numberOfItems(in pageViewController: HXPageViewController) -> Int {
        return titles.count
    }
    
    func pageViewController(_ pageViewController: HXPageViewController, titleForItemAt index: Int) -> String {

        return titles[index]
    }
    
    func pageViewController(_ pageViewController: HXPageViewController, childViewContollerAt index: Int) -> UIViewController {
        if (self.titles[index] == "ホーム") {
            let detailVC: CollectionsViewController = self.storyboard!.instantiateViewController()
            return detailVC
        }else{
            let detailVC: ProductsViewController = self.storyboard!.instantiateViewController()
            detailVC.collection = self.collections[index - 1]
            return detailVC
        }
    }
    
}
