//
//  LoginViewController.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/12.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var loginView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let coverView = UIView()
        coverView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        coverView.backgroundColor = UIColor.blackColor()
        coverView.alpha = 0.2
        loginView.addSubview(coverView)

        // Do any additional setup after loading the view.
    }

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

}
