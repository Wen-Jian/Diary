//
//  DiaryListTableViewCell.swift
//  Collection apps
//
//  Created by Mac on 2017/7/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class DiaryListTableViewCell: UITableViewCell {

    @IBOutlet weak var diaryimage: UIImageView!
    @IBOutlet weak var diarytext: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
