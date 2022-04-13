//
//  Margarita.swift
//  MakeYourMargarita
//
//  Created by Александра Лесовская on 10.04.2022.
//

import Foundation

struct Margarita: Decodable {
    
    // MARK: - Public Properties
    let strDrink: String?
    let strAlcoholic: String?
    let strDrinkThumb: String?
    let strInstructions: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    
    
    var composition: String {
        var compositionInStringFormat = "Ingredients: "
        let allIngredients = [
            strIngredient1,
            strIngredient2,
            strIngredient3,
            strIngredient4,
            strIngredient5,
            strIngredient6,
            strIngredient7,
            strIngredient8,
            strIngredient9,
            strIngredient10,
            strIngredient11,
            strIngredient12,
            strIngredient13,
            strIngredient14,
            strIngredient15
        ]

        for index in 0...allIngredients.count - 1 {
            if let ingredient = allIngredients[index] {
                compositionInStringFormat += " \(ingredient),"
            }
        }
        compositionInStringFormat.remove(
            at: compositionInStringFormat.index(
                before: compositionInStringFormat.endIndex)
        )
        return compositionInStringFormat
    }
    
    // MARK: - Initializers
    init(margaritaData: [String : Any]) {
        self.strDrink = margaritaData["strDrink"] as? String
        self.strAlcoholic = margaritaData["strAlcoholic"] as? String
        self.strDrinkThumb = margaritaData["strDrinkThumb"] as? String
        self.strInstructions = margaritaData["strInstructions"] as? String
        self.strIngredient1 = margaritaData["strIngredient1"] as? String
        self.strIngredient2 = margaritaData["strIngredient2"] as? String
        self.strIngredient3 = margaritaData["strIngredient3"] as? String
        self.strIngredient4 = margaritaData["strIngredient4"] as? String
        self.strIngredient5 = margaritaData["strIngredient5"] as? String
        self.strIngredient6 = margaritaData["strIngredient6"] as? String
        self.strIngredient7 = margaritaData["strIngredient7"] as? String
        self.strIngredient8 = margaritaData["strIngredient8"] as? String
        self.strIngredient9 = margaritaData["strIngredient9"] as? String
        self.strIngredient10 = margaritaData["strIngredient10"] as? String
        self.strIngredient11 = margaritaData["strIngredient11"] as? String
        self.strIngredient12 = margaritaData["strIngredient12"] as? String
        self.strIngredient13 = margaritaData["strIngredient13"] as? String
        self.strIngredient14 = margaritaData["strIngredient14"] as? String
        self.strIngredient15 = margaritaData["strIngredient15"] as? String
    }
    

    // MARK: - Static Methods
    static func getMargaritas(from value: Any) -> [Margarita] {
        guard let margaritasData = value as? [[String: Any]] else { return [] }
        return margaritasData.compactMap { Margarita(margaritaData: $0) }
    }
    
}

struct Drink: Decodable {
    
    // MARK: - Public Properties
    let drinks: [Margarita]
    
    // MARK: - Static Methods
    static func getDrink(from value: Any) -> Drink {
        guard let drink = value as? [String : Any] else { return Drink(drinks: []) }
        guard let drinksDictionary = drink["drinks"] as? [[String : Any]] else { return Drink(drinks: []) }
        return Drink(drinks: Margarita.getMargaritas(from: drinksDictionary))
    }
    
}
