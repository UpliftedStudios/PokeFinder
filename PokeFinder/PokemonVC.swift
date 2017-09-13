//
//  PokemonVC.swift
//  PokeFinder
//
//  Created by Raphael M. Hidalgo on 9/9/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import UIKit

protocol DataSentDelegate {
    func userDidEnterData(data: Int)
}

class PokemonVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: DataSentDelegate?
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: UITouch? = touches.first
        if touch?.view != collection {
            self.view.isHidden = true
            }
        }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(pokemonName: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            
            let poke: Pokemon!
            
            if inSearchMode {
                
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
                
            } else {
                
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
                
            }
            
            return cell
            
            
        } else {
            
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            
            poke = filteredPokemon[indexPath.row]
            
        } else {
            
            poke = pokemon[indexPath.row]
            
        }
     
        if delegate != nil {
            
                let data = poke.pokedexId
                delegate?.userDidEnterData(data: data!)
                dismiss(animated: true, completion: nil)
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokemon.count
            
        }
        
        return 151
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collection.reloadData()
            
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.pokemonName?.range(of: lower) != nil})
            collection.reloadData()
            
        }
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonVC" {
            if let detailsVC = segue.destination as? PokemonVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = [poke]
                    
                }
            }
        }
    }
}
    



