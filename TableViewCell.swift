//
//  TableViewCell.swift
//  SplitRoomBill
//
//  Created by girishbodhe on 23/10/18.
//  Copyright © 2018 girishbodhe. All rights reserved.
//

import UIKit

class RecentSpendingsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var recentSpendingsImageview: UIImageView!
    @IBOutlet weak var rescentSpendingsName: UILabel!
    @IBOutlet weak var rescentSpendingsDate: UILabel!
    @IBOutlet weak var rescentSpendingsAmount: UILabel!
    @IBOutlet weak var rescentSpendingsStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
