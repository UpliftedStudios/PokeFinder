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
    var pokeArray = [PokeAnnotation]()
    var myCoordinate = CLLocationCoordinate2DMake(0, 0)
    
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
            
            let pokeAnno = PokeAnnotation(coordinate: myCoordinate, pokemonNumber: indexPath.row + 1)
            
            cell.configureCell(pokeAnno)
            
            
            return cell
        } else {
            
        return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if delegate != nil {
            if collection != nil {
                let data = indexPath.row + 1
                delegate?.userDidEnterData(data: data)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view != collection {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}
