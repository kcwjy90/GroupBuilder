//
//  LoginModel.swift
//  GroupBuilder
//
//  Created by ppc90 on 4/30/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import CryptoKit
import AuthenticationServices
import FirebaseDatabase

// to be used in AuthApple ()
enum NeedToGetAuthStatus {
    case needToGetUserName
    case presentTabBar
    case none
}

class LoginModel: NSObject {
    
    var currentNonce: String?
    
    override init() {
        super.init()
        
    }
    
    /* === Step 2. nonce 만들고, sha256 처리
     nonce: random number to prevent replay attacks
     Sha256: hash function that takes a string and spits out a value that is 256 bits long.
     보안을 위한 암호화. another layer of protection on top of Apple Login
     === */
    func startSignInWithAppleFlow() -> ASAuthorizationController {
        
        let nonce = randomNonceString()
        currentNonce = nonce //멤버변수로
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationContoller = ASAuthorizationController(authorizationRequests: [request])
        
        return authorizationContoller
        
    }
    
    // =====Copy & Pasted to use generate Nonce and Sha256. Adapted from=== https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    //===================================================================
    
    //Apple Authorization
    func authApple(idTokenString: String,
                   appleIDCredential: ASAuthorizationAppleIDCredential,
                   completion: @escaping ((NeedToGetAuthStatus, Error?) -> Void)) {
        
        //appleIDCredential and idTokenString from LoginVC
        let fbCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                    idToken: idTokenString,
                                                    rawNonce: currentNonce)
        
        let appleCredential = appleIDCredential.user
        
//                DELETE after adding FB ===
        let error = NSError(domain: "ERROR", code: -1)
        completion(.presentTabBar, error)
//                DELETE after adding FB ===

//                5/16 일단 commented===

        /* === Step 4. Firebase Login 시도 - Initialize a Firebase credential ========
         2번의 nonce, 3번의 appleId, idToken 전달
         */
        
//        Auth.auth().signIn(with: fbCredential) { (authResult, error) in
//            if let error = error {
//                completion(.none, error)
//                return
//            }
            
            
            /* === Step 5. Firebase Login 성공: Access_token 전달받음 ======== */
//            print("Firebase Sign In Success")
//            
//            guard let authResult = authResult else {
//                let error = NSError(domain: "NS Error for AuthResult", code: -1)
//                completion(.none, error)
//                return
//            }
//            
//            authResult.user.getIDToken(completion: { (token, error) in
//                if let error = error {
//                    completion(.none, error)
//                    return
//                }
//                
//                guard let accessToken = token else {
//                    let error = NSError(domain: "accessToken Error", code: -1)
//                    completion(.none, error)
//                    return
//                }
//                
//                guard let fbUser = Auth.auth().currentUser else {
//                    let error = NSError(domain: "fbUser Error", code: -1)
//                    completion(.none, error)
//                    return
//                    
//                }
//                
//                self.fbUserId = fbUser.uid
//                
//                print("accessToken: \(accessToken)")
//                print("fbUserId: \(self.fbUserId)")
                
                //위에서 받은 fbUserId와 appleCredential을 addUserData func을 call 해 database에 저장
//                self.addUserData(appleCredential: appleCredential) { needToGetAuthStatus, error in
//                    if let error = error {
//                        completion(.none, error)
//                        return
//                    }
//                    
//                    //Setting userDefault isLogin to keep currentUser data until app is deleted
//                    UserDefaults.standard.set(self.fbUserId, forKey: "isLogin") //userDefaults에 fbUserId (fbID)를 저장
//                    completion(needToGetAuthStatus, nil) //성공할경우
//                    
//                }
//            })
//        }
//                5/16 일단 commented===
        
    }
    
    
    
}
