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
//        
//        if(FBSDKAccessToken.currentAccessToken() != nil){
//            print("User Already Logged In")
//            self.performSegueWithIdentifier("ModalFromLoginToSwipeSegue", sender: self)
//        }
//
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
                    //fb情報取得
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
                            let imageUrl = NSURL(string: result.valueForKey("picture")!.valueForKey("data")?.valueForKey("url") as! String)
//                            let imageUrl = NSURL(string: "http://chatnoir666.com/wp-content/uploads/2015/03/knuttz-ueba-305111.jpg")
                            
//                            let imageView = UIImageView()
//                            imageView.af_setImageWithURL(imageUrl!)
//                            print(imageView.image)
//                            imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//                            let imageData = UIImageJPEGRepresentation(imageView.image!, 0.8)
//                            let image = PFFile(name: "image.jpg", data: imageData!)
//
    
//                            let req = NSURLRequest(URL:imageUrl!)
//                            //非同期で変換
//                            NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
//                                imageView.image = UIImage(data:data!)
//                            }
//                            let imageData = UIImageJPEGRepresentation(imageView.image!, 0.8)
//                            let image = PFFile(name: "image.jpg", data: imageData!)
                            
//                            let req = Alamofie.request(.GET, imageUrl!)
//                            Alamofire.
//                            req.response() { (request, response, data, error) in
//                                if error == nil {
//                                    dispatch_async(dispatch_get_main_queue()) { () in
//                                        self.photoImage.image = UIImage(data: data as NSData)
//                                    }
//                                }
//                            }
                            
                            let imageUIData = NSData(contentsOfURL: imageUrl!)
                            let UIImg = UIImage(data:imageUIData!);

//                            let imageData = UIImageJPEGRepresentation(UIImg!, 1.0)
//                            let image = PFFile(name: "image.jpeg",data: imageData!)
                            
//                            let ratio = UIImg.size.width / UIImg.size.height
//                            image = resizeIm
                            let imageData = UIImagePNGRepresentation(UIImg!)!
                            let image = PFFile(name: "image.png", data: imageData)
//                            let file = PFFile(data: UIImageJPEGRepresentation(UIImg!))
                            let user = User(username: name, age: age, gender: userGender!, image: image!, password: password, email: email)
                            user.signUp({ (message) -> Void in
                                print("サインアップしました")
                            })                            //                let profileImageURL : String = reu.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
                            //                var profileImage = UIImage(data: NSData(contentsOfURL: NSURL(string: profileImageURL)!)!)
//                            print("Name: \(name), Email: \(email), Gender: \(gender)")
                        }
                    
                    })
                    
                    
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
