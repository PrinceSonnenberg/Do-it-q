//
//  CategoryViewController.swift
//  Do it
//
//  Created by Prince Sonnenberg on 2019/01/11.
//  Copyright © 2019 Prince Sonnenberg. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var nameArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        
        loadCategory()
        
        
        
    }
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = nameArray[indexPath.row].name
        
        return cell
    
    }
    //MARK: - Tableview Data Source
    
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC =  segue.destination as! DoITViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = nameArray[indexpath.row]
            
        }
        
    }
    
    
    
    // MARK: - Data Manipulation Methods - Save data and load data
    
   

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         // MARK: - Add New Categories
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once user presses add item on uialert
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            //newItem.done = false
            self.nameArray.append(newCategory)
            
            self.saveCategory()
            
        }
            alert.addAction(action)
        
            alert.addTextField{( field) in
            textField = field
            field.placeholder = "Add a New Category"
            
            
        }
        
        
        self.present(alert,animated: true, completion: nil)
        
    }
    
    
    func saveCategory(){
        
        do {
            try context.save()
        } catch {
            print("Error saving data, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            nameArray =  try context.fetch(request)
        } catch{
            print("Error getting data from context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
        //MARK:- Tableview Delegate Methods
        
    }

