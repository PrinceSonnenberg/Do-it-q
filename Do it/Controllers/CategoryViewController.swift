//
//  CategoryViewController.swift
//  Do it
//
//  Created by Prince Sonnenberg on 2019/01/11.
//  Copyright © 2019 Prince Sonnenberg. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
            loadCategory()
        
    }
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    
    }
    //MARK: - Tableview Data Source
    
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC =  segue.destination as! DoITViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexpath.row]
            
        }
        
    }
    
    // MARK: - Data Manipulation Methods - Save data and load data
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         // MARK: - Add New Categories
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once user presses add item on uialert
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
            alert.addAction(action)
        
            alert.addTextField{( field) in
            textField = field
            field.placeholder = "Add a New Category"
            
            
        }
        
        
        self.present(alert,animated: true, completion: nil)
        
    }
    
    
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving data, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
  func loadCategory() {
    
        categories = realm.objects(Category.self)
    
        tableView.reloadData()
    
    }
    
}
