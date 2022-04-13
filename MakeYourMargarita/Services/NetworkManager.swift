//
//  NetworkManager.swift
//  MakeYourMargarita
//
//  Created by Александра Лесовская on 10.04.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

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
                print(drink)
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
    
    func fetchDataWithAlamofire(completion: @escaping(Result<[Margarita], NetworkError>) -> Void) {
        AF.request("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita")
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let drink = Drink.getDrink(from: value)
                    let margaritas = drink.drinks
                    completion(.success(margaritas))
                case .failure(let error):
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
        
    }
    
}





