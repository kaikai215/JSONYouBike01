//
//  PlaceTableViewCell.swift
//  JSONYouBike
//
//  Created by Ryan on 2024/4/26.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var PlaceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PlaceLabel.font = UIFont(name: "Iansui-Regular", size: 30)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
