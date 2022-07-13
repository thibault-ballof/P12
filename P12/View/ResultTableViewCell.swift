//
//  ResultTableViewCell.swift
//  P12
//
//  Created by Thibault Ballof on 11/07/2022.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var visitorImage: UIImageView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var t1Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
