//
//  UIButtonAnimated.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/13.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit

class UIButtonAnimated: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches , withEvent: event)
        self.touchStartAnimation()
    }    
    
    override func  touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        self.touchEndAnimation()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        self.touchEndAnimation()
    }
    
    private func touchStartAnimation(){
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {() -> Void in
                self.transform = CGAffineTransformMakeScale(0.85, 0.85);
                self.alpha = 0.7
            },
            completion: nil
        )
    }
    private func touchEndAnimation(){
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {() -> Void in
                self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                self.alpha = 1
            },
            completion: nil
        )
    }
    
}