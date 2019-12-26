//
//  signUpViewController.swift
//  MyStoreSwift
//
//  Created by Zheng Gong on 2019/11/25.
//  Copyright © 2019 Adfurikun. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        Client.shared.signUp(firstName: firstName.text ?? "", lastName: lastName.text ?? "", email: email.text ?? "", password: password.text ?? ""){_ in
            
        }
    }
    
    
}
