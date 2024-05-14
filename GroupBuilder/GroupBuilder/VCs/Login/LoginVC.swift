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

class LoginVC: UIViewController, UITabBarControllerDelegate {

    lazy var contentView: LoginView = LoginView()
    let model: LoginModel = LoginModel()

    //For Tabbar (1/2)
    let tabBarCtlr = UITabBarController()
    
    let todayVC: TodayVC = TodayVC()
    let calendarVC: CalendarVC = CalendarVC()
    let progressVC: ProgressVC = ProgressVC()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(contentView)
        contentView.frame = view.frame
        
        navigationVCs()
        
    }
    
    func navigationVCs() {
        
        //For Tabbar (2/2)
        tabBarCtlr.tabBar.isTranslucent = false //both lines needed
        tabBarCtlr.tabBar.backgroundColor = .white //to change tabbar color
        UITabBar.appearance().tintColor = .black
        
        let todayNavi = UINavigationController(rootViewController: todayVC)
        todayVC.title = "Today"
        
        let calendarNavi = UINavigationController(rootViewController: calendarVC)
        calendarVC.title = "Calendar"
        
        let progressNavi = UINavigationController(rootViewController: progressVC)
        progressVC.title = "Progress"
        
        tabBarCtlr.modalPresentationStyle = .fullScreen
        tabBarCtlr.setViewControllers([todayNavi, calendarNavi, progressNavi], animated: false)
        
    }

}

