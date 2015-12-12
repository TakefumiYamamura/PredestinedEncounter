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


class LoginViewController: UIViewController {
    @IBOutlet weak var loginView: UIImageView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var subDiscription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let coverView = UIView()
        coverView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        coverView.backgroundColor = UIColor.blackColor()
        coverView.alpha = 0.3
        loginView.addSubview(coverView)
        
        topTitle = makeShadow(topTitle)
        subDiscription = makeShadow(subDiscription)
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = CGPoint(x: view.center.x, y: view.frame.height*3/4 )
        loginButton.layer.cornerRadius = 30
        
        
        loginButton.layer.shadowRadius = 0
        loginButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        loginButton.layer.shadowColor  = UIColor.blackColor().CGColor
        loginButton.layer.shadowOpacity = 0.8
        loginButton.layer.shadowRadius = 5
        view.addSubview(loginButton)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
