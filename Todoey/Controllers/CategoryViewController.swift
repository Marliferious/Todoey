//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Chris Marler on 2019-10-06.
//  Copyright © 2019 Chris Marler. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

   let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
 
    //MARK: TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if categories is not nil, result the count, but if it is, return a 1 (Nil Coalescing Operator)
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
       
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
    
    
      //MARK: - Add New Categories
    
    
    @IBAction func addButtonPresshed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //What will happen once user clicks the Add Item Button on your UIAlert
            
            let newCategory = Category()
            newCategory.name = textField.text!
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
