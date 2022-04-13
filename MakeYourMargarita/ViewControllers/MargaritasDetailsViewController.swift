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
    
    @IBOutlet var margaritasNameLabel: UILabel!
    @IBOutlet var margaritasTypeLabel: UILabel!
    @IBOutlet var margaritasIngredientsLabel: UILabel!
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
        margaritasImageView.image = image
        margaritasImageView.layer.cornerRadius = 30
        margaritasNameLabel.text = margarita.strDrink ?? ""
        margaritasTypeLabel.text = margarita.strAlcoholic ?? ""
        margaritasIngredientsLabel.text = margarita.composition
        margaritasDescriptionLabel.text = margarita.strInstructions ?? ""
    }
    
}
