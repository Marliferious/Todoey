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
    
        //allows us to save to the document directory for the app, so we can save and load info from the plist into the array
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
        override func viewDidLoad() {
        super.viewDidLoad()
  
        
        print (dataFilePath)
        

        loadItems()

        
    }

  
    
    //MARK - TableView DataSource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none   //set the cell.accessory type to checkmark is true, none if false
    
        return cell
    }
    
    //MARK - TableVue Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
      
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
            
            self.saveItems()
       
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
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
        }
        tableView.reloadData()  //reloads table to accept new data
    }
    
    func loadItems() {
        // pulls data from plist into tableView, aka Decode
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error, \(error)")
            }
            
        }
        
        
    }
    
}

