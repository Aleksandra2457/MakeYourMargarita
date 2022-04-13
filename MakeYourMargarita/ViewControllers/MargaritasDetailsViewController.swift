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
    var image: UIImage!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Private Methods
    private func updateUI() {
        margaritasImageView.layer.cornerRadius = 30
        margaritasDescriptionLabel.text = "\(margarita.strDrink ?? "")\n\n\(margarita.strAlcoholic ?? "")\n\n\(margarita.composition)\n\n\(margarita.strInstructions ?? "")"
        NetworkManager.shared.fetchImage(from: margarita.strDrinkThumb, completion: { image in
            self.margaritasImageView.image = UIImage(data: image)
        })
    }
    
}
