//
//  ContentsViewController.swift
//  MyStoreSwift
//
//  Created by Zheng Gong on 2019/12/06.
//  Copyright © 2019 Adfurikun. All rights reserved.
//


import UIKit
import MobileBuySDK
import Apollo
import AlamofireImage

class ContentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    public var micropostData: [MicropostsQuery.Data.Micropost]? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CustomCellTableViewCell
        // セルに表示する値を設定する
//            cell.myTextView?.text = content
//            print(content)
        print(micropostData?[indexPath.row].content)
        cell.myTextView?.text = micropostData?[indexPath.row].content
        
        if (micropostData?[indexPath.row].picture != nil) {
            cell.myImageView?.af_setImage(withURL: URL(string: (micropostData?[indexPath.row].picture)!)!)
        }

        return cell
    }
    
    @IBOutlet weak var userName: UILabel!
    var apollo: ApolloClient? = nil
    

    @IBAction func showusername(_ sender: Any) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        let apiPath: String = String(format: "http://localhost:3000/graphql")
        let url = NSURL(string: apiPath)
        self.apollo = ApolloClient(networkTransport: HTTPNetworkTransport(url: url as! URL,sendOperationIdentifiers: false))
        apollo?.fetch(query: MicropostsQuery()) { result in
          switch result {
          case .success(let graphQLResult):
            if let name = graphQLResult.data?.microposts {
                self.micropostData = name
                self.myTableView.reloadData()
            } else if let errors = graphQLResult.errors {
              // GraphQL errors
              print(errors)
            }
          case .failure(let error):
            // Network or response format errors
            print(error)
          }
        }
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Cellの高さを決める

        return 350
    }
}

extension UIImageView{
    func setImageUrl(_ string : String?) {
        if(string != nil){
            let url = URL(string: string!)!
            self.af_setImage(withURL: url)
        }
    }
}

