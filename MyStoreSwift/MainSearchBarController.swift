//
//  MainSearchBarController.swift
//  MyStoreSwift
//
//  Created by Zheng Gong on 2019/11/21.
//  Copyright © 2019 Adfurikun. All rights reserved.
import UIKit
import MobileBuySDK

class MainSearchBarController: UIViewController {


    var collections : [CollectionViewModel] = []
    // ----------------------------------

    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        searchBar.delegate = self
    }
    
    func searchFetchCollections(query cursor: String? = nil) -> Int{
        Client.shared.searchFetchCollections(query: cursor ?? "") { collections in
            if let collections = collections?.items {
                self.collections = collections
            }
        }
        return self.collections.count
    }
    
}


extension MainSearchBarController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let detailVC: CollectionsViewController = self.storyboard!.instantiateViewController()
        detailVC.searchKeyWord = searchBar.text ?? ""
        if (self.searchFetchCollections(query: detailVC.searchKeyWord) != 0){
            self.present(detailVC, animated: true, completion: nil)
        }else{
            let title = "検索結果が見つかりませんでした"
            let message = "ホームに戻ります"
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okayButton)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
