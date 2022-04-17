//
//  MargaritasTypesTableViewController.swift
//  MakeYourMargarita
//
//  Created by Александра Лесовская on 10.04.2022.
//

import UIKit

class MargaritasTypesTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    var margaritas: [Margarita] = []

    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMargaritas()
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return margaritas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MargaritasTableViewCell", for: indexPath)
        let margarita = margaritas[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = margarita.strDrink ?? ""
        content.secondaryText = margarita.composition
        content.secondaryTextProperties.adjustsFontSizeToFitWidth = true
        
        if let imageURL = margarita.strDrinkThumb {
            NetworkManager.shared.fetchImage(from: imageURL) { result in
                switch result {
                case .success(let imageData):
                    content.image = UIImage(data: imageData)
                    content.imageProperties.cornerRadius = 20
                    cell.contentConfiguration = content
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MargaritasDetailsViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.margarita = margaritas[indexPath.row]
        }
    }
    
    private func fetchMargaritas() {
        NetworkManager.shared.fetchDataWithAlamofire { result in
            switch result {
            case .success(let margaritas):
                self.margaritas = margaritas
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
 
}
