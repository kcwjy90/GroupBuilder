//
//  TodayVC.swift
//  GroupBuilder
//
//  Created by ppc90 on 5/9/24.
//

import UIKit

class TodayVC: UIViewController {

    lazy var contentView: TodayView = TodayView()
    let model: TodayModel = TodayModel()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(contentView)
        contentView.frame = view.frame
 
    }
    
}
