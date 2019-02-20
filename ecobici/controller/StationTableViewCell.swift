//
//  StationTableViewCell.swift
//  ecobici
//
//  Created by John A. Cristobal on 2/20/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var bicisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }

}
