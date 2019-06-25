//
//  PokemonController.swift
//  PokeDexInClass
//
//  Created by Nic Gibson on 6/25/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation

class PokemonController {
    
    // Singleton
    static let sharedInstance = PokemonController()
    
    // Create
    func fetchPokemonWith (searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        
        // Build URL
        let baseURL = URL(string: "https://pokeapi.co/api/v2")
        let pokemonPathComponentURL = baseURL?.appendingPathComponent("pokemon")
        guard let finalURL = pokemonPathComponentURL?.appendingPathComponent(searchTerm) else
        {return}
        print(finalURL)
        
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            //Handle the error
            if let error = error {
                print("Error getting data. \(error.localizedDescription)")
            }
            //Check if there's data
            if let data = data {
                // Decode and handle the data
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(pokemon)
                } catch {
                    print("Error fetching Pokemon!")
                    completion(nil);return
                }
            }
        } .resume()
    }
}
