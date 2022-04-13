//
//  MargaritasTableViewCell.swift
//  MakeYourMargarita
//
//  Created by Александра Лесовская on 13.04.2022.
//

import UIKit

class MargaritasTableViewCell: UITableViewCell {

    @IBOutlet var margaritasImageView: UIImageView!
    @IBOutlet var margaritasNameLabel: UILabel!
    @IBOutlet var margaritasIngredientsLabel: UILabel!
    
    func configure(with margarita: Margarita) {
        margaritasNameLabel.text = margarita.strDrink ?? ""
        margaritasIngredientsLabel.text = margarita.composition
        margaritasIngredientsLabel.adjustsFontSizeToFitWidth = true
        NetworkManager.shared.fetchImage(from: margarita.strDrinkThumb) { image in
            self.margaritasImageView.image = UIImage(data: image)
        }
        margaritasImageView.layer.cornerRadius = 20
    }
    
}
