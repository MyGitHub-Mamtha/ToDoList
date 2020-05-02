//
//  ViewController.swift
//  ToDoList
//
//  Created by Mamtha S Talwar on 29/04/20.
//  Copyright © 2020 Mamtha S Talwar. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var toDoArray = ["First","Second","Third"]
    
    // userdefault object creation
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
       // retrieve assigned values to userdefaults
        if let item = defaults.array(forKey: "ToDoArray") as? [String] {
        toDoArray = item
        }
    }
  //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoList", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }

}
  //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what will happen once user clicks on add item button
            self.toDoArray.append(textField.text!)
            // set default values
            self.defaults.setValue(self.toDoArray, forKey: "ToDoArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (addTextField) in
            addTextField.placeholder = "Create New Item"
            textField = addTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

