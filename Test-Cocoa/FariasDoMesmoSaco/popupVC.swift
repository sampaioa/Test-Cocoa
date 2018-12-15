//
//  popupVC.swift
//  
//
//  Created by Andre Sampaio on 12/12/18.
//

import UIKit
import FBSDKLoginKit


class popupVC: UIViewController, FBSDKLoginButtonDelegate {
    
        @IBOutlet weak var closePopupVCBT: UIButton!
    
    @IBOutlet weak var loginDescLB: UILabel!
    
    @IBOutlet weak var loginView: UIView!
    
    
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
        
        let loginButton = FBSDKLoginButton()
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



