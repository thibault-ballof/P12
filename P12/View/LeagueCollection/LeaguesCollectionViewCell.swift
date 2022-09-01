//
//  LeaguesCollectionViewCell.swift
//  P12
//
//  Created by Thibault Ballof on 13/06/2022.
//

import UIKit

class LeaguesCollectionViewCell: UICollectionViewCell {

    //MARK: OUTLETS
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var label: UILabel!

    
    override func awakeFromNib() {
            super.awakeFromNib()

        }
    //MARK: Set up circle cells
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
            self.layer.cornerRadius = self.frame.size.width / 2
        }

 


}
