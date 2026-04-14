//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray: [Item] = []

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
        .appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title

        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add new todo", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { action in

            self.itemArray.append(Item(title: textField.text!, done: false))
            self.saveItems()
        }

        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    func saveItems() {
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error : \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: dataFilePath!)
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("errror")
        }
        
    }
    
}
