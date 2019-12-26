//
//  StartPostViewController.swift
//  MyStoreSwift
//
//  Created by Zheng Gong on 2019/12/13.
//  Copyright © 2019 Adfurikun. All rights reserved.
//

import UIKit
import Apollo
import Alamofire
import SwiftyJSON

class StartPostViewController: UIViewController {
    var apollo: ApolloClient? = nil
    var data:Data? = nil
    var pictureUrl:URL? = nil
    let apiPath: String = String(format: "http://localhost:3000/graphql")
    let fileUploadApiPath: String = String(format: "http://localhost:3000/image_file/upload")
    var pictureLocalModel: PictureLocalModel? = nil
    @IBOutlet weak var setPicture: UIImageView!
    
    @IBAction func close(_ sender: Any) {
        self.uploadImage()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var micropost: UITextField!
    
    @IBAction func cotext(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let url = NSURL(string: apiPath)
        print(setPicture)
        self.apollo = ApolloClient(networkTransport: HTTPNetworkTransport(url: url as! URL,sendOperationIdentifiers: false))
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.setPicture = nil
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        print("点击了相册")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    
    private func uploadImage() {
        if (self.setPicture.image != nil) {
            let dataA = "title".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            let dataB = "image".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            let dataC = self.setPicture.image!.pngData()!
            Alamofire.upload(multipartFormData: { (multipartFormData) in
            // 送信データを設定
            multipartFormData.append(dataA, withName: "title", mimeType: "text/plain")
            multipartFormData.append(dataB, withName: "name", mimeType: "text/plain")
            multipartFormData.append(dataC, withName: "image", fileName: "image"+".png", mimeType: "image/png")
                
            }, to: fileUploadApiPath) { (encodingResult) in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in // ← JSON形式で受け取る
                        if !response.result.isSuccess {
                            print("# ERROR")
                            self.pictureLocalModel!.image = ""
                            self.setPicture.image = nil
                        } else {
                            print("# SUCCESS")
                            let jsonData = JSON.init(response.result.value as Any)
                            self.pictureLocalModel = PictureLocalModel.init(jsonData: jsonData)
                            print(self.pictureLocalModel!.image)
                            self.apollo?.perform(mutation: MicropostMutation(content: self.micropost.text ?? "",picture: self.pictureLocalModel!.image)) { result in
                                guard let data = try? result.get().data else { return }
                            }
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }

        
    }
}

extension StartPostViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image : UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        setPicture.image = image
        let pickedURL = info[UIImagePickerController.InfoKey.imageURL]as! URL
        self.pictureUrl = pickedURL
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: {
        })
    }
}

struct PictureLocalModel {
   var image : String

   init(jsonData: JSON) {
       image = jsonData["image"].stringValue
   }
}

