//
//  MessageListTableViewCell.swift
//  PredestinedEncounter
//
//  Created by TakefumiYamamura on 2015/12/13.
//  Copyright © 2015年 ids. All rights reserved.
//

import UIKit

class MessageListTableViewCell: UITableViewCell {

    @IBOutlet weak var listImageview: UIImageView!
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listText: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
