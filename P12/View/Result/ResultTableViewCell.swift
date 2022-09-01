//
//  ResultTableViewCell.swift
//  P12
//
//  Created by Thibault Ballof on 11/07/2022.
//

import UIKit
import Lottie

class ResultTableViewCell: UITableViewCell {

    //MARK: OUTLETS
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var t2Label: UILabel!
    @IBOutlet weak var visitorImage: UIImageView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var t1Label: UILabel!
    @IBOutlet weak var redDot: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Setup Animation from Lottie
        animationView.contentMode = .scaleAspectFit
          animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        animationView.play()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

    // MARK: Setup UI for cells
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.borderWidth = 0.2
        layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
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
