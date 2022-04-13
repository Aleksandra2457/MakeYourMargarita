//
//  NetworkManager.swift
//  MakeYourMargarita
//
//  Created by Александра Лесовская on 10.04.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(_ completion: @escaping (Drink) -> ()) {
        
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Something went wrong")
                return
            }
            
            do {
                let drink = try JSONDecoder().decode(Drink.self, from: data)
                DispatchQueue.main.async {
                    completion(drink)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    func fetchImage(from url: String?, completion: @escaping (Data) -> Void)  {
        guard let stringURL = url else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
}





