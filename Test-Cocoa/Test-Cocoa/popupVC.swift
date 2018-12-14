//
//  popupVC.swift
//  
//
//  Created by Andre Sampaio on 12/12/18.
//

import UIKit
import FBSDKLoginKit


class popupVC: UIViewController, FBSDKLoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("erro")
            return
        }
        print("Você logou com sua conta do Facebook...")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Você deslogou do Facebook")
    }
    
    @IBOutlet weak var closePopupVCBT: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        //Replace frames by constrains, frames are obsolete
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        
        
        loginButton.delegate = self
    }
    
    @IBAction func Click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}



