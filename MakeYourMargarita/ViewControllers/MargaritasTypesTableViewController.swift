//
//  MargaritasTypesTableViewController.swift
//  MakeYourMargarita
//
//  Created by Александра Лесовская on 10.04.2022.
//

import UIKit

class MargaritasTypesTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    var margaritas: [Margarita] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var margaritasImages: [UIImage?] = []

    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.fetchData() { drink in
            self.margaritas += drink.drinks
            self.updateImages()
        }
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return margaritas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MargaritasDescriptionCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let margarita = margaritas[indexPath.row]
        content.text = margarita.strDrink ?? ""
        content.secondaryText = margarita.composition
        content.image = UIImage(named: "BaseImage2")
        content.imageProperties.cornerRadius = 30
        cell.contentConfiguration = content
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func updateImages() {
        margaritas.forEach { margarita in
            NetworkManager.fetchImage(margarita.strDrinkThumb) { image in
                self.margaritasImages.append(image)
            }
        }
    }
 
}
