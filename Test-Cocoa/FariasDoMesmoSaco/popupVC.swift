//
//  popupVC.swift
//  
//
//  Created by Andre Sampaio on 12/12/18.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn


class popupVC: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
        @IBOutlet weak var closePopupVCBT: UIButton!
    
    @IBOutlet weak var loginDescLB: UILabel!
    
    @IBOutlet weak var loginView: UIView!
    
    let googleButton = GIDSignInButton()
    let loginButton = FBSDKLoginButton()
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("erro")
            return
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters:["fields": "id, name, email"])?.start(completionHandler: { (connection, result, err) in
            if err != nil {
                print("Erro ao iniciar Graph request", err)
                return
            }
            
            print(result)
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Você deslogou do Facebook")
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFacebookButtons()
        setupGoogleButtons()
        }
    
    fileprivate func setupGoogleButtons() {
        //Add Google button
        
        googleButton.frame = CGRect(x: 16, y: loginButton.frame.origin.y + loginButton.frame.height + 20 , width: view.frame.width - 32, height: 50)
        loginView.addSubview(googleButton)
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
    }
    
    fileprivate func setupFacebookButtons() {
        //Add Facebook button
        
        loginView.addSubview(loginButton)
        //Replace frames by constrains, frames are obsolete
        loginButton.frame = CGRect(x: 16, y: loginDescLB.frame.origin.y + loginDescLB.frame.height + 20 , width: view.frame.width - 32, height: 50)
        
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
    }
    
    
    @IBAction func Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}



