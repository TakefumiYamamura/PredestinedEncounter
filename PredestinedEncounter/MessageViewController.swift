//
//  ViewController.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/11/22.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit
import Pusher
import Alamofire
import SwiftyJSON
import JSQMessagesViewController
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class MessageViewController: JSQMessagesViewController, PTPusherDelegate  {
    var client: PTPusher!
    var messages: [JSQMessage]?
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var adminBubble: JSQMessagesBubbleImage!
    var incomingAvatar: JSQMessagesAvatarImage!
    var outgoingAvatar: JSQMessagesAvatarImage!
    var adminAvatar: JSQMessagesAvatarImage!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.client = PTPusher(key: "81719acd3b6bbac02706", delegate: self,encrypted: true)
        self.client.connect()

        self.senderId = "user1"
        self.senderDisplayName = "hoge"
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        UIColor.jsq_messageBubbleBlueColor()
        self.incomingBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
        self.outgoingBubble = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
        self.adminBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleRedColor())
        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "cute_girl.jpg")!, diameter: 64)
        self.outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "yamamura.jpg")!, diameter: 64)
        self.adminAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "mumu.png")!, diameter: 64)
        self.messages = []
        let message = JSQMessage(senderId: "user3", displayName: "underscore", text: "マッチングおめでとうございます！まずは合コンをするにあたって，お二方の都合の良い場所を教えてください！")
        self.messages?.append(message)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        //新しいメッセージデータを追加する
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        self.messages?.append(message)
        
        //メッセージの送信処理を完了する(画面上にメッセージが表示される)
        self.finishReceivingMessageAnimated(true)
        
        //擬似的に自動でメッセージを受信
        self.receiveAutoMessage()
    }
    
    //アイテムごとに参照するメッセージデータを返す
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.messages?[indexPath.item]
    }
    
    //アイテムごとのMessageBubble(背景)を返す
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = self.messages?[indexPath.item]
        switch message!.senderId! {
        case "user1":
            return self.outgoingBubble
        case "user2":
            return self.incomingBubble
        case "user3":
            return self.adminBubble
        default:
            break
        }
        return self.incomingBubble
    }
    
    //アイテムごとにアバター画像を返す
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = self.messages?[indexPath.item]
        switch message!.senderId! {
        case "user1":
            return self.outgoingAvatar
        case "user2":
            return self.incomingAvatar
        case "user3":
            return self.adminAvatar
        default:
            break
        }
        return self.adminAvatar
    }
    
    //アイテムの総数を返す
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.messages?.count)!
    }
    
    //返信メッセージを受信する
    func receiveAutoMessage() {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "didFinishMessageTimer:", userInfo: nil, repeats: false)
    }
    
    func didFinishMessageTimer(sender: NSTimer) {
        let message = JSQMessage(senderId: "user2", displayName: "underscore", text: "美月っていいます! 下北沢に住んでます！！　渋谷らへんでやりたいです！！！ ")
        self.messages?.append(message)
        self.finishReceivingMessageAnimated(true)
    }
    

}

