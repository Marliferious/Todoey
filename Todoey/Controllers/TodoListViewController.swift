//
//  ViewController.swift
//  Todoey
//
//  Created by Chris Marler on 2019-08-24.
//  Copyright © 2019 Chris Marler. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
        loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
     
    }
    
    //MARK - TableView DataSource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
        
            //set the cell.accessory type to checkmark is true, none if false
            cell.accessoryType = item.done == true ? .checkmark : .none
        
        } else {
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
    
    //MARK - TableVue Delegate Methods
    
    //cell is selected and toggled
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write {
 
                    item.done = !item.done   //item.done is toggled
                }
            } catch {
                print("Error \(error)")
            }
        }
        
        tableView.reloadData()
   
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      
     
            //What will happen once user clicks the Add Item Button on your UIAlert
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                } catch {
                    print ("Error saving new items \(error)")
                }
                
                self.tableView.reloadData()  //reloads table to accept new data
            }
    
             
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    //MARK: Model Manipulation Methods
    
    
    // pulls data from plist into tableView, aka Encode
//    func saveItems(todoItems: Item) {
//
//        do {
//            try realm.write {
//                realm.add(todoItems)
//            }
//        }  catch {
//            print ("Error saving context \(error)")
//        }
//        tableView.reloadData()  //reloads table to accept new data
//    }
    
    
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
     
        tableView.reloadData()

}
}

//MARK: - Search Bar Methods
extension TodoListViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
     
        tableView.reloadData()  //Will not update unless you do this

        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 00{
            loadItems()
 
            //DispatchQueue put the action on the main theeard, not background thread
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
