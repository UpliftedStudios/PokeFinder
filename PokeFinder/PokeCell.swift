//
//  PokeCell.swift
//  PokeFinder
//
//  Created by Raphael M. Hidalgo on 9/8/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    var pokeAnno: PokeAnnotation!

    func configureCell(_ pokeAnno: PokeAnnotation) {
        
        self.pokeAnno = pokeAnno
        
        thumbImg.image = UIImage(named: "\(self.pokeAnno.pokemonNumber)")
    }
    
}
