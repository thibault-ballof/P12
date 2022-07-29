//
//  ResultTableViewCell.swift
//  P12
//
//  Created by Thibault Ballof on 11/07/2022.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var t2Label: UILabel!
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
    override func layoutSubviews() {
        super.layoutSubviews()
        // Setup UI for Cell
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.borderWidth = 0.1
        layer.borderColor = UIColor.gray.cgColor
        // Apply a shadow
        layer.shadowRadius = 20.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.origin.x += 4
            frame.size.height -= 10
            frame.size.width -= 10
            super.frame = frame
        }
      }
    
}
