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

    let alert = UIAlertController()
    
    //For Tabbar (1/2)
    let tabBarCtlr = UITabBarController()
    
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(contentView)
        
        contentView.frame = view.frame
        contentView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonPressed), for: .touchUpInside)
        
        navigationVCs()
            
    }
    
    // === Step 1. Apple 로그인 버튼 탭. Continues in Model === //
    @objc func appleLoginButtonPressed() {
        
        let authorizationController = model.startSignInWithAppleFlow()
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
//        self.present(self.tabBarCtlr, animated: true) // LoginVC -> TabBar
 
    }
    
    //VCs for TabBarCtlr
    func navigationVCs() {
        
        let todayVC: TodayVC = TodayVC()
        let calendarVC: CalendarVC = CalendarVC()
        let progressVC: ProgressVC = ProgressVC()
        
        //==For Tabbar (2/2)========================
        tabBarCtlr.tabBar.isTranslucent = false //both lines needed
        tabBarCtlr.tabBar.backgroundColor = .white //to change tabbar color
        UITabBar.appearance().tintColor = .black
        //==========================================
        
        let todayNavi = UINavigationController(rootViewController: todayVC)
        todayVC.title = "Today"
        todayVC.tabBarItem.image = UIImage(named: "today")
        
        let calendarNavi = UINavigationController(rootViewController: calendarVC)
        calendarVC.title = "Calendar"
        calendarVC.tabBarItem.image = UIImage(named: "calendar")
        
        let progressNavi = UINavigationController(rootViewController: progressVC)
        progressVC.title = "Progress"
        progressVC.tabBarItem.image = UIImage(named: "progress")
        
        tabBarCtlr.modalPresentationStyle = .fullScreen
        tabBarCtlr.setViewControllers([todayNavi, calendarNavi, progressNavi], animated: false)
        
    }

}

extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    /* === Step 3. 애플 인증 처리 - AppleID, idToken. ========
     
     idToken: 안에는 나의 아이디랑 패스워드가 들어가 있는데 이것을 그대로 보냈을때 보안에 문제가 생길수 있으니, 이것을 한 번 더 감써서 안전하게 보내는것. 이것을 OAuth라고 부른다.
     
     */
    
    //Must 생성 (auto) when you create authorizationController in step 1
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let appleIdToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
                
                let error = NSError(domain: "Unable to fetch identity token and serialize token string from data", code: -1)
                
                alert.title = "Problem with Apple Login"
                alert.message = "\(error)"
                
                return
                
            }
            
            
            
            model.authApple(idTokenString: idTokenString, appleIDCredential: appleIDCredential) { needToGetAuthStatus, error in
                
//                5/16 일단 commented     ===
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//                5/16 일단 commented     ===

//              DELETE after adding FB ===
                
                switch needToGetAuthStatus {
                
                case .presentTabBar:
                    self.present(self.tabBarCtlr, animated: true) // LoginVC -> TabBar
                    
                case .none:
                    return
                    
                case .needToGetUserName:
                    return
                }
//                DELETE after adding FB ===
               
//                5/16 일단 commented===

//                switch needToGetAuthStatus {
//                    
//                case .presentTabBar:
//                    guard let fbUserIdReceived = self.model.fbUserId else {return}
//
//                    self.ledgerTableVC.model.fbId = fbUserIdReceived
//                    self.ledgerTableVC.fbId = fbUserIdReceived
//                    
//                    self.present(self.tabBarCtlr, animated: true)
//                    
//                case .needToGetUserName:
//                    print("LoginVC - needToGetUserName")
//                    guard let fbUserIdReceived = self.model.fbUserId else {return}
//                    
//                    let userNameVC = UserNameVC(fbId: fbUserIdReceived)
//                    userNameVC.delegate = self
//                    
//                    self.present(userNameVC, animated: true)
//                    
//                case .none:
//                    return
//                }
//                5/16 일단 commented===

            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
}
