//
//  DiarycontentTableViewCell.swift
//  Collection apps
//
//  Created by Mac on 2017/8/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class DiarycontentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var diaryimage: UIImageView!

    @IBOutlet weak var diarycontent: UITextField!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
