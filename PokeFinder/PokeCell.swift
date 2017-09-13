//
//  PokeCell.swift
//  PokeFinder
//
//  Created by Raphael M. Hidalgo on 9/9/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!

    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon

        thumbImg.image = UIImage(named: "\(pokemon.pokedexId!)")
        
    }
    
}
