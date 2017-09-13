//
//  Pokemon.swift
//  PokeFinder
//
//  Created by Raphael M. Hidalgo on 9/9/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import Foundation

class Pokemon {
    
    var pokemonName: String?
    var pokedexId: Int?
    
    init(pokemonName: String, pokedexId: Int) {
        
        self.pokemonName = pokemonName
        self.pokedexId = pokedexId
    }
}
