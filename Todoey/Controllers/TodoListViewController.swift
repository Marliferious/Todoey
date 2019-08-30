//
//  ViewController.swift
//  Todoey
//
//  Created by Chris Marler on 2019-08-24.
//  Copyright © 2019 Chris Marler. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard  //required to store data persistantly
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let newItem = Item()
        newItem.title = "Find Inner Peace"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Get a bigger slice of pie"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Nuke the whales"
        itemArray.append(newItem3)
        
   
        
        
  //      if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
 //           itemArray = items
  //      }
        
        
    }

  
    
    
    
    
    
    
    
    //MARK - TableView DataSource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        return cell
    }
    
    //MARK - TableVue Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   //         print (itemArray[indexPath.row])
        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false
        }
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }  else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    
    //MARK - Add new Items
        
        
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                    //What will happen once user clicks the Add Item Button on your UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")  //all values are persistantly saved in key value pairs
            
            self.tableView.reloadData()  //reloads table to accept new data
        }

        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            
            textField = alertTextField
            
           
            
        }
        
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
        
        
    }
    
    
    
}

