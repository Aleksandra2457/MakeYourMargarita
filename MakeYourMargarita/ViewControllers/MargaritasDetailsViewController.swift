//
//  MargaritasDetailsViewController.swift
//  MakeYourMargarita
//
//  Created by Александра Лесовская on 10.04.2022.
//

import UIKit

class MargaritasDetailsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var margaritasImageView: UIImageView!
    @IBOutlet var margaritasDescriptionLabel: UILabel!
    
    // MARK: - Public Properties
    var margarita: Margarita!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Private Methods
    private func updateUI() {
        margaritasImageView.layer.cornerRadius = 30
        margaritasDescriptionLabel.text = "\(margarita.strDrink ?? "")\n\n\(margarita.strAlcoholic ?? "")\n\n\(margarita.composition)\n\n\(margarita.strInstructions ?? "")"
        if let imageURL = margarita.strDrinkThumb {
            NetworkManager.shared.fetchImage(from: imageURL) { result in
                switch result {
                case .success(let imageData):
                    self.margaritasImageView.image = UIImage(data: imageData)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
}


