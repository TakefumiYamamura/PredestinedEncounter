//
//  SwipeViewController.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/11/27.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit
import MDCSwipeToChoose
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class SwipeViewController: UIViewController, MDCSwipeToChooseDelegate, FBSDKLoginButtonDelegate{
    let likeButton = UIButtonAnimated()
    let nopeButton = UIButtonAnimated()
    let loginButton = FBSDKLoginButton()
//    var users:[User] = []
    let userManger = UserManager.sharedInstance

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        userManger.fetchUsers()
        loginButton.delegate = self
//        let backgroundView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
//        backgroundView.image = UIImage(named: "couple-running-beach.jpg")
//        backgroundView.contentMode = UIViewContentMode.ScaleAspectFill
//        self.view.addSubview(backgroundView)
//        
//        let coverView = UIView()
//        coverView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
//        coverView.backgroundColor = UIColor.blackColor()
//        coverView.alpha = 0.7
//        self.view.addSubview(coverView)
        
//    
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "LIKE"
        options.likedColor = UIColor.blueColor()
        options.nopeText = "NOPE"
        options.onPan = { state -> Void in
            if state.thresholdRatio == 1 && state.direction == MDCSwipeDirection.Left {
                print("Photo deleted!")
            } else if state.thresholdRatio == 1 && state.direction == MDCSwipeDirection.Right {
                print("Photo saved!")
            }
        }
    
        let swipeView = MDCSwipeToChooseView(frame: self.view.bounds, options: options)
//        view.autoresizingMask = []
//        let view = NDCSwipeTo
        
        swipeView.imageView.image = UIImage(named: "cute_girl.jpg")
        swipeView.imageView.frame = CGRectMake(0, 0, self.view.frame.width - 40, self.view.frame.width - 40 )
//        view.imageView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin]
        swipeView.frame = CGRectMake(20, 100, self.view.frame.width - 40, self.view.frame.width + 30)
        
        let nameLabel = UILabel(frame: CGRect(x: 15, y: self.view.frame.width - 30, width: 100, height: 50))
        nameLabel.text = "むぅむ" + ",　" + "20"
//        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
//        let ageLabel  = UILabel(frame: CGRect(x: self.view.frame.width/2, y: self.view.frame.width - 30, width: 100, height: 50))
//        ageLabel.text = "22" + "years "
//        
//        swipeView.addSubview(ageLabel)
        swipeView.addSubview(nameLabel)
        
        self.view.addSubview(swipeView)
        
        likeButton.setImage(UIImage(named: "like47.png"), forState: .Normal)
        nopeButton.setImage(UIImage(named: "close33.png"), forState: .Normal)
        
        likeButton.frame.size = CGSize(width: 70, height: 70)
        likeButton.center = CGPoint(x: self.view.center.x + 70, y: self.view.frame.height - 70)
        
        nopeButton.frame.size = CGSize(width: 70, height: 70)
        nopeButton.center = CGPoint(x: self.view.center.x - 70, y: self.view.frame.height - 70)
        
        self.view.addSubview(likeButton)
        self.view.addSubview(nopeButton)
        
//        self.navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        self.title = "mu-mu-"
//        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "social12.png")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "social12.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "toMessageListViewController")
//        self.navigationController?.navigationBar.frame = CGRectMake(self.view.center.x, 16, 32, 32)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Mu-Mu--logo.png"), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.titleTextAttributes =
//            [NSForegroundColorAttributeName: UIColor.whiteColor(),
//                NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 20)!]
//        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "toMessageListViewController")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
    }
    
    
    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(view: UIView) -> Void{
        print("Couldn't decide, huh?")
    }
    
    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(view: UIView, shouldBeChosenWithDirection: MDCSwipeDirection) -> Bool{
        if (shouldBeChosenWithDirection == MDCSwipeDirection.Left || shouldBeChosenWithDirection == MDCSwipeDirection.Right ) {
            return true;
        } else {
            // Snap the view back and cancel the choice.
            UIView.animateWithDuration(0.16, animations: { () -> Void in
                view.transform = CGAffineTransformIdentity
                view.center = view.superview!.center
            })
            return false;
        }
    }
    
    // This is called then a user swipes the view fully left or right.
    func view(view: UIView, wasChosenWithDirection: MDCSwipeDirection) -> Void{
        if wasChosenWithDirection == MDCSwipeDirection.Left {
            print("Photo deleted!")
        }
        if wasChosenWithDirection == MDCSwipeDirection.Right {
            print("Photo saved!")
        }
    }
    
    func toMessageListViewController(){
        self.performSegueWithIdentifier("ShowToMessageListTableViewController", sender: nil)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!,didCompleteWithResult
        result: FBSDKLoginManagerLoginResult!, error: NSError!) {
            
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        PFUser.logOut()
        self.performSegueWithIdentifier("modalLoginViewController", sender: self)
    }
    
    func logout(){
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        PFUser.logOut()
        self.performSegueWithIdentifier("modalLoginViewController", sender: self)
    }
    
    
}
