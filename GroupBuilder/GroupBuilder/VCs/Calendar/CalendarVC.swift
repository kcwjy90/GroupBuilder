//
//  CalendarVC.swift
//  GroupBuilder
//
//  Created by ppc90 on 5/9/24.
//

import UIKit

class CalendarVC: UIViewController {

    lazy var contentView: CalendarView = CalendarView()
    let model: CalendarModel = CalendarModel()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(contentView)
        contentView.frame = view.frame
 
    }

}
