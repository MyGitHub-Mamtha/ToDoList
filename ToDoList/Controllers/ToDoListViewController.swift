//
//  ViewController.swift
//  ToDoList
//
//  Created by Mamtha S Talwar on 29/04/20.
//  Copyright © 2020 Mamtha S Talwar. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var toDoArray = [Item]()
//    // userdefault object creation-----> 0
//    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        print(dataFilePath)
       // retrieve assigned values to userdefaults ---- 2
//        if let items = defaults.array(forKey: "ToDoArray") as? [Item] {
//        toDoArray = items
        
        
    }
    
  //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellforrowat")
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoList", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row].title
        let item = toDoArray[indexPath.row]
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       toDoArray[indexPath.row].done = !toDoArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
       

}
  //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what will happen once user clicks on add item button
            let newItem = Item()
            newItem.title = textField.text!
            self.toDoArray.append(newItem)
//            // set default values ----> 1
//            self.defaults.setValue(self.toDoArray, forKey: "ToDoArray")
            self.saveItems()
        }
        alert.addTextField { (addTextField) in
            addTextField.placeholder = "Create New Item"
            textField = addTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

func saveItems() {
    //NSCODER ----> 0
    let encoder = PropertyListEncoder()
    do {
        let data = try encoder.encode(toDoArray)
        try data.write(to: dataFilePath!)
    } catch {
        print("error")
    }
    tableView.reloadData()
    
}
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            toDoArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error")
            }
    }
}
}
