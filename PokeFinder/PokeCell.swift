//
//  PokeCell.swift
//  PokeFinder
//
//  Created by Raphael M. Hidalgo on 8/8/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    var pokeNumber: NumberArray!
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        layer.cornerRadius = 5.0
//    }
    
    func configureCell(_ pokeNumber: NumberArray) {
        
        self.pokeNumber = pokeNumber
        
        thumbImg.image = UIImage(named: "\(self.pokeNumber.pokeNumber)")
        
    }
}
