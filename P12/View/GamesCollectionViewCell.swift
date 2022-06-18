//
//  GamesCollectionViewCell.swift
//  P12
//
//  Created by Thibault Ballof on 13/06/2022.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    
    
    private var cornerRadius: CGFloat = 5.0
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var Label: UILabel!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
                
            // Apply rounded corners to contentView
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = true
            
            // Set masks to bounds to false to avoid the shadow
            // from being clipped to the corner radius
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            
            // Apply a shadow
            layer.shadowRadius = 8.0
            layer.shadowOpacity = 0.10
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 5)
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

