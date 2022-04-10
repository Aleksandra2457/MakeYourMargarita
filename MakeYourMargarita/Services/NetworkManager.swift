//
//  NetworkManager.swift
//  MakeYourMargarita
//
//  Created by Александра Лесовская on 10.04.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    let shared = NetworkManager()
    
    static func fetchData(_ completion: @escaping (Drink) -> ()) {
        
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Something went wrong")
                return
            }
            
            do {
                let drink = try JSONDecoder().decode(Drink.self, from: data)
                completion(drink)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    private init() {}
    
}





