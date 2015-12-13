//
//  LoginViewController.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/12.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginView: UIImageView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var subDiscription: UILabel!
    let loginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        let coverView = UIView()
        coverView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        coverView.backgroundColor = UIColor.blackColor()
        coverView.alpha = 0.3
        loginView.addSubview(coverView)
        
        topTitle = makeShadow(topTitle)
        subDiscription = makeShadow(subDiscription)
        loginButton.center = CGPoint(x: view.center.x, y: view.frame.height*3/4 )
        loginButton.layer.cornerRadius = 30
        loginButton.layer.shadowRadius = 0
        loginButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        loginButton.layer.shadowColor  = UIColor.blackColor().CGColor
        loginButton.layer.shadowOpacity = 0.8
        loginButton.layer.shadowRadius = 5
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile", "user_friends"]
        view.addSubview(loginButton)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        if(FBSDKAccessToken.currentAccessToken() != nil){
//            print("User Already Logged In")
//            self.performSegueWithIdentifier("ModalFromLoginToSwipeSegue", sender: self)
//        }
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!,didCompleteWithResult
        result: FBSDKLoginManagerLoginResult!, error: NSError!) {
            print("User Logged In")
            
            if ((error) != nil)
            {
                print("error")
            } else if result.isCancelled {
                //キャンセルされた時
            } else {
                //必要な情報が取れていることを確認(今回はemail必須)
                if result.grantedPermissions.contains("email")
                {
                    print(result.grantedPermissions.contains("email"))
                    self.performSegueWithIdentifier("ModalFromLoginToSwipeSegue", sender: self)
                }
            }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    
    func makeShadow(label: UILabel) -> UILabel {
        label.layer.shadowRadius = 0
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowColor  = UIColor.blackColor().CGColor
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 5
    
        return label
    }
    
//    func didTouchButton(){
//        let loginManger = FBSDKLoginManager()
//        loginManger.logOut()
//        print("dfadsfaf")
//    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
