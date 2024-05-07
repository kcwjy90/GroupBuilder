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
        v.text = "GROUP"
        v.textColor = .white
        v.font = UIFont.systemFont(ofSize: 30)
        v.textAlignment = .center
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(title)
        
        title.snp.makeConstraints{ (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(-100)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        backgroundColor = .systemOrange

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
