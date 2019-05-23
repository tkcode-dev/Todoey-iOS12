//
//  ViewController.swift
//  Todoey-iOS12
//
//  Created by USER on 2019-05-21.
//  Copyright © 2019 taka. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{

//    var itemArray = ["buy milk","buy meron","buy eggs"]
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//
//    let defaults = UserDefaults.standard
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        loadItems()
//        let newItem = Item()
//        newItem.title = "buy milk"
//        itemArray.append(newItem)
//        let newItem2 = Item()
//        newItem2.title = "buy meron"
//        itemArray.append(newItem2)
//        let newItem3 = Item()
//        newItem3.title = "buy eggs"
//        itemArray.append(newItem3)
//        if let items = defaults.array(forKey: "saveItemList") as? [Item] {
//            itemArray = items
//        }
    }

    //MARK: - TABLEVIEW DATASOURCE METHOD
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
    
    //MARK: - Tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
//        print(itemArray[indexPath.row])
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        saveItems()
        
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @IBAction func addBtnItems(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
//
//            self.defaults.set(self.itemArray, forKey: "saveItemList")
//
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model manupilation method
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
            do {
                itemArray = try context.fetch(request)
            } catch {
                print("Error fetching data from context, \(error)")
            }
        tableView.reloadData()
        }
    }

    //MARK: - Serch bar Methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
