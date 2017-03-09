//
//  TableViewCell.swift
//  SimpleAPICallDemo
//
//  Copyright © 2017 Rajesh. All rights reserved.
//

import UIKit

class TableViewCellClass: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageViewLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
