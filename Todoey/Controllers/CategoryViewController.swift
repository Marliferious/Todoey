//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Chris Marler on 2019-10-06.
//  Copyright © 2019 Chris Marler. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
   let realm = try! Realm()
    
   var categories: Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        tableView.separatorStyle = .none
//        tableView.rowHeight = 80.0
    }
 
    //MARK: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if categories is not nil, result the count, but if it is, return a 1 (Nil Coalescing Operator)
        return categories?.count ?? 1
    }
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // creation of cell using superclass, and then cell is modified
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        
//        var existingColor: String = categories![indexPath.row].color
        
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "12000")
        
//        print(existingColor)
        
//        cell.backgroundColor = color ??  UIColor.randomFlat
        
//        cell.backgroundColor = UIColor.randomFlat
//        cell.backgroundColor = UIColor.randomFlat.hexValue()
//        cell.backgroundColor = UIColor(hexString: <#T##String#>)
        

        return cell
    }
    
      //MARK: - Data Manipulation Methods
 
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print ("Error saving context \(error)")
        }
        tableView.reloadData()  //reloads table to accept new data
    }
    
    func loadCategories(){
       categories = realm.objects(Category.self)
       tableView.reloadData()
      }
 
    //MARK: - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
        
    }
    
     //MARK: - Add New Categories
    
 
    
    @IBAction func addButtonPresshed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //What will happen once user clicks the Add Item Button on your UIAlert
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            
//            self.categories.append(newCategory)
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
          present(alert, animated: true, completion: nil)
    }
  
    //MARK: TABLEVIEW Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            
    }
    
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
//         self.saveCategories()
        
    //    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

}



