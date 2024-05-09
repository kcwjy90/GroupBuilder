//
//  ProgressVC.swift
//  GroupBuilder
//
//  Created by ppc90 on 5/9/24.
//

import UIKit

class ProgressVC: UIViewController {

    lazy var contentView: ProgressView = ProgressView()
    let model: ProgressModel = ProgressModel()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(contentView)
        contentView.frame = view.frame
 
    }

}
