//
//  LoginView.swift
//  GroupBuilder
//
//  Created by ppc90 on 4/30/24.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    lazy var title: UILabel = {
        let v = UILabel()
        v.text = "GroupBuilder"
        v.textColor = .white
        v.font = UIFont.systemFont(ofSize: 50)
        v.textAlignment = .center
        return v
    }()
    
    lazy var addIconLater: UILabel = {
        let v = UILabel()
        v.text = "G"
        v.textColor = .white
        v.font = UIFont.systemFont(ofSize: 50)
        v.textAlignment = .center
        return v
    }()
    
    lazy var appleLoginButton: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(named: "apple"), for: .normal)
        v.setTitle(" Continue with Apple", for: .normal)
        v.frame = CGRect(x: 0, y: 200, width: 200, height: 50)
        v.backgroundColor = .black
        v.layer.cornerRadius = 10
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(title)
        addSubview(addIconLater)
        addSubview(appleLoginButton)
        
        title.snp.makeConstraints{ (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(250)
        }
        
        addIconLater.snp.makeConstraints{ (make) in
            make.centerX.equalTo(title)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        addIconLater.backgroundColor = .systemPurple
        
        appleLoginButton.snp.makeConstraints{ (make) in
            make.centerX.equalTo(title)
            make.bottom.equalTo(addIconLater).offset(200)
            make.width.equalTo(303)
            make.height.equalTo(54)
        }
        backgroundColor = .systemOrange

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
