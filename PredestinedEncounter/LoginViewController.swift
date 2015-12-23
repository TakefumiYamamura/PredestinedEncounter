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
import AlamofireImage
import Alamofire

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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
                if result.grantedPermissions.contains("email")
                {

                    let graphRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email, gender, age_range, picture.type(large), id"])
                    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                        if ((error) != nil) {
                            print("Error: \(error)")
                        } else {
                            let name = result.valueForKey("name") as! String
                            let email = result.valueForKey("email") as! String
                            let gender = result.valueForKey("gender") as! String
                            let userGender = UserGender(rawValue: gender)
                            let age = result.valueForKey("age_range")!.valueForKey("min") as! Int
                            let password = result.valueForKey("id") as! String
                            let image = result.valueForKey("picture")!.valueForKey("data")?.valueForKey("url") as! String
                            let user = User(username: name, age: age, gender: userGender!, image: image, password: password, email: email)
                            user.signUp({ (message) -> Void in
                                print("サインアップしました")
                            })
                        }
                    
                    })
                    self.performSegueWithIdentifier("ModalFromLoginToSwipeSegue", sender: self)
                }
            }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        self.performSegueWithIdentifier("modalLoginViewController", sender: self)
        PFUser.logOut()
        
    }
    
    
    
    func makeShadow(label: UILabel) -> UILabel {
        label.layer.shadowRadius = 0
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowColor  = UIColor.blackColor().CGColor
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 5
    
        return label
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
