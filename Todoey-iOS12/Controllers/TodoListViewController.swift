//
//  ViewController.swift
//  Todoey-iOS12
//
//  Created by USER on 2019-05-21.
//  Copyright © 2019 taka. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

//    var itemArray = ["buy milk","buy meron","buy eggs"]
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "buy milk"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "buy meron"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "buy eggs"
        itemArray.append(newItem3)
        if let items = defaults.array(forKey: "saveItemList") as? [Item] {
            itemArray = items
        }
    }

    // MARK - TABLEVIEW DATASOURCE METHOD
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
       
        return cell
    }
    
    // MARK - Tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        tableView.reloadData()
        
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add New Items
    @IBAction func addBtnItems(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "saveItemList")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

