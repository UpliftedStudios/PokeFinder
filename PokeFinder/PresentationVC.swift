//
//  PresentationVC.swift
//  PokeFinder
//
//  Created by Raphael M. Hidalgo on 9/8/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//


//THIS IS THE SENDING VC
import Foundation
import UIKit
import MapKit

protocol DataSentDelegate {
    func userDidEnterData(data: Int)
}

class PresentationVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    var delegate: DataSentDelegate?
    var pokemons = [PokeAnnotation]()
    var filteredPokes = [PokeAnnotation]()
    var myCoordinate = CLLocationCoordinate2DMake(0, 0)
    var inSearchMode = false
    
    override func viewDidLoad() {
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        collection.layer.cornerRadius = 10
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
//            let pokeAnno = PokeAnnotation(coordinate: myCoordinate, pokemonNumber: indexPath.row + 1)
            
            let pokeAnno: PokeAnnotation!
            
            if inSearchMode {
                
                pokeAnno = filteredPokes[indexPath.row]
                cell.configureCell(pokeAnno)
                
            } else {
            
            pokeAnno = pokemons[indexPath.row]
            cell.configureCell(pokeAnno)
                
            }
            
            return cell
            
        } else {
            
        return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokes.count
        } else {
            
        return pokemon.count
        }
    }
        
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: PokeAnnotation
        
        if inSearchMode {
            
            poke = filteredPokes[indexPath.row + 1]
        } else {
            
            poke = pokemons[indexPath.row + 1]
        }
        
        if delegate != nil {
            if collection != nil {
                let poke = indexPath.row + 1
                delegate?.userDidEnterData(data: poke)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            collection.reloadData()
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokes = pokemons.filter({$0.pokemonName.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        searchBar.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view != collection {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}
