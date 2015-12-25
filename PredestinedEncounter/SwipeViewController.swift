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
    let users:[User] = []
    let userManger = UserManager.sharedInstance

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.delegate = self
        userManger.fetchSwipeUsers { () -> Void in
            print("success callback")
            if let swipeView = self.popSwipeView(){
                self.view.addSubview(swipeView)
            }
        }
        likeButton.setImage(UIImage(named: "like47.png"), forState: .Normal)
        nopeButton.setImage(UIImage(named: "close33.png"), forState: .Normal)
        
        likeButton.frame.size = CGSize(width: 70, height: 70)
        likeButton.center = CGPoint(x: self.view.center.x + 70, y: self.view.frame.height - 70)
        likeButton.addTarget(self, action: "likeFrontCardView", forControlEvents: UIControlEvents.TouchUpInside)
        
        nopeButton.frame.size = CGSize(width: 70, height: 70)
        nopeButton.center = CGPoint(x: self.view.center.x - 70, y: self.view.frame.height - 70)
        nopeButton.addTarget(self, action: "nopeFrontCardView", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(likeButton)
        self.view.addSubview(nopeButton)
        
        self.navigationController!.navigationBar.barTintColor = UIColor.hexStr("#77D4DA", alpha: 1)
        self.title = "Mu-Mu-"
        self.navigationController!.navigationItem.titleView = UIImageView(image: UIImage(named: "Mu-Mu--logo.png"))
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func viewDidCancelSwipe(view: UIView) -> Void{
        print("Couldn't decide, huh?")
    }
    
    func view(view: UIView, shouldBeChosenWithDirection: MDCSwipeDirection) -> Bool{
        if (shouldBeChosenWithDirection == MDCSwipeDirection.Left || shouldBeChosenWithDirection == MDCSwipeDirection.Right ) {
            return true;
        } else {
            UIView.animateWithDuration(0.16, animations: { () -> Void in
                view.transform = CGAffineTransformIdentity
                view.center = view.superview!.center
            })
            return false;
        }
    }
    
    func view(view: UIView, wasChosenWithDirection: MDCSwipeDirection) -> Void{
        if wasChosenWithDirection == MDCSwipeDirection.Left {
            print("Photo deleted!")
        }
        if wasChosenWithDirection == MDCSwipeDirection.Right {
            print("Photo saved!")
        }
        if let swipeView = popSwipeView(){
            self.view.addSubview(swipeView)
        }

    }
    
    @IBAction func toMessageListViewController(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowToMessageListTableViewController", sender: nil)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!,didCompleteWithResult
        result: FBSDKLoginManagerLoginResult!, error: NSError!) {
            
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        PFUser.logOut()
        self.performSegueWithIdentifier("modalLoginViewController", sender: self)
    }
    
    @IBAction func logout(sender: AnyObject) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        PFUser.logOut()
        self.performSegueWithIdentifier("modalLoginViewController", sender: self)
    }
    
    func popSwipeView() -> MDCSwipeToChooseView?{
        print(userManger.swipeUsers)
        if(userManger.swipeUsers.count == 0){
            return nil;
        }
        let user = userManger.swipeUsers[0]
        userManger.swipeUsers.removeAtIndex(0)
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
        let imageUrl = NSURL(string: user.image)
        let imageData = NSData(contentsOfURL: imageUrl!)
        swipeView.imageView.image = UIImage(data: imageData!)
        swipeView.imageView.frame = CGRectMake(0, 0, self.view.frame.width - 40, self.view.frame.width - 40 )
        swipeView.frame = CGRectMake(20, 100, self.view.frame.width - 40, self.view.frame.width + 30)
        let nameLabel = UILabel(frame: CGRect(x: 15, y: self.view.frame.width - 30, width: self.view.frame.width, height: 50))
        nameLabel.text = user.username + ",　" + String(user.age)
        swipeView.addSubview(nameLabel)
        return swipeView
    }
    
    func nopeFrontCardView() -> Void{
        self.view.subviews[4].mdc_swipe(MDCSwipeDirection.Left)
        print(self.view.subviews)
    }
    func likeFrontCardView() -> Void{
        self.view.subviews[4].mdc_swipe(MDCSwipeDirection.Right)
    }
    
}
