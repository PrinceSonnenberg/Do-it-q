//
//  ViewController.swift
//  Do it
//
//  Created by Prince Sonnenberg on 2019/01/03.
//  Copyright © 2019 Prince Sonnenberg. All rights reserved.
//

import UIKit
import CoreData

class DoITViewController: UITableViewController {
    
    var itemArray  = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       let request:NSFetchRequest<Item> = Item.fetchRequest()
        
       
}
    

    //MARK: - 1. Create TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
        }
  
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
    
        //Ternary operator==>
        // value = condition ? valueiftrue : valueiffalse
        
        cell.accessoryType = item.done == true ? . checkmark : .none

        return cell
    }
    

    // MARK: -2. Create Tableview Delegate Methods
    //(to detect which row is selected using didselect) Then we establish initial cell behaviour
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
  //      context.delete(itemArray[indexPath.row])
  //      itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
    
        tableView.deselectRow(at: indexPath, animated: true)
    
    }

    //MARK: - 3. Add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New DoIt item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user presses add item on uialert
            
    
         let newItem = Item(context: self.context)
         newItem.title = textField.text!
         newItem.done = false
         newItem.parentCategory = self.selectedCategory
         self.itemArray.append(newItem)
        
         self.saveItems()
        
        }
    
        alert.addTextField{( alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
          
         
    }
        alert.addAction(action)
        self.present(alert,animated: true, completion: nil)
        
        }

    //MARK: - 4. Model manipulation functions
    
    func saveItems(){
    
        do {
           try context.save()
        } catch {
            print("Error saving data, \(error)")
        }
        
        self.tableView.reloadData()
        
        }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate:NSPredicate? = nil){

        let categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate, additionalPredicate])
        }
        else {
            request.predicate = categorypredicate
            
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate, predicate])
//
//        request.predicate = predicate
        
        do{
            itemArray =  try context.fetch(request)
        } catch{
            print("Error getting data from context, \(error)")
        }
        
        tableView.reloadData()
    }

}
//MARK: - 5. Searchbar Functions
    
extension DoITViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        
      let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor (key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
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

// VID 169 -13:47
