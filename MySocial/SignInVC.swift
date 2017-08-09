//
//  ViewController.swift
//  MySocial
//
//  Created by Scott Callery on 05/08/2017.
//  Copyright © 2017 Scott Callery. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Firebase


class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = LoginManager()
        
        facebookLogin.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if (error != nil) {
                print("Unable to sign in with Firebase")
            } else {
                print("Successful sign in with Firebase")
                
            }
        }
        
    }
    
}
