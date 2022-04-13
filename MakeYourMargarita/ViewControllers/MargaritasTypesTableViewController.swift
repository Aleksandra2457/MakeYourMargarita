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
        NetworkManager.shared.fetchData() { drink in
            self.margaritas = drink.drinks
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return margaritas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MargaritasTableViewCell", for: indexPath) as! MargaritasTableViewCell
        let margarita = margaritas[indexPath.row]
        cell.configure(with: margarita)
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
 
}
