//
//  LeaguesCollectionViewCell.swift
//  P12
//
//  Created by Thibault Ballof on 13/06/2022.
//

import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    private var cornerRadius: CGFloat = 5.0
    
    override func awakeFromNib() {
            super.awakeFromNib()

        }
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
            self.layer.cornerRadius = self.frame.size.width / 2
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            
            // Improve scrolling performance with an explicit shadowPath
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: cornerRadius
            ).cgPath
}


}
