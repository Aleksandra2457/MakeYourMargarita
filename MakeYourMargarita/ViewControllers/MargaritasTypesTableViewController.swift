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
    
    var margaritasImages = [
        "Margarita",
        "Blue Margarita",
        "Tommy's Margarita",
        "Whitecap Margarita",
        "Strawberry Margarita",
        "Smashed Watermelon Margarita"
    ]

    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.fetchData() { drink in
            self.margaritas = drink.drinks
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
        content.secondaryTextProperties.adjustsFontSizeToFitWidth = true
        content.image = UIImage(named: margaritasImages[indexPath.row])
        content.imageProperties.cornerRadius = 30
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MargaritasDetailsViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.margarita = margaritas[indexPath.row]
            destination.image = UIImage(named: margaritasImages[indexPath.row])
        }
    }
 
}
