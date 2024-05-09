 //
//  LoginVCC.swift
//  GroupBuilder
//
//  Created by ppc90 on 5/6/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import AuthenticationServices

class LoginVC: UIViewController {

    lazy var contentView: LoginView = LoginView()
    let model: LoginModel = LoginModel()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(contentView)
        contentView.frame = view.frame
 
    }

}

