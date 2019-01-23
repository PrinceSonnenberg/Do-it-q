//
//  ViewController.swift
//  Do it
//
//  Created by Prince Sonnenberg on 2019/01/03.
//  Copyright © 2019 Prince Sonnenberg. All rights reserved.
//

import UIKit
import RealmSwift

class DoITViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var doITitems: Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
         loadItems()
        }
    }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       
}

    //MARK: - 1. Create TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return doITitems?.count ?? 1
        
        }
  
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
        if let item = doITitems?[indexPath.row]{
            
            cell.textLabel?.text = item.title
            
            //Ternary operator==>
            // value = condition ? valueiftrue : valueiffalse
            
            cell.accessoryType = item.done ? . checkmark : .none
            
        } else {
            
            cell.textLabel?.text = "No Items Added"
            
        }
        
        

        return cell
    }
    

    // MARK: -2. Create Tableview Delegate Methods
    //(to detect which row is selected using didselect) Then we establish initial cell behaviour
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
  //      context.delete(doITitems[indexPath.row])
  //      doITitems.remove(at: indexPath.row)
        
//        doITitems[indexPath.row].done = !doITitems[indexPath.row].done
//
//        saveItems()
    
        tableView.deselectRow(at: indexPath, animated: true)
    
    }

    //MARK: - 3. Add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New DoIt item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        //what will happen once user presses add item on uialert
            
            if let currentCategory = self.selectedCategory {
                do{
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                    }
                } catch {
                    
                    print("error saving new items, \(error)")
                    
                }
                
                self.tableView.reloadData()
            }
        
        }
    
        alert.addTextField{( alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
          
         
    }
        alert.addAction(action)
        self.present(alert,animated: true, completion: nil)
        
        }

    //MARK: - 4. Model manipulation functions
    
    func loadItems(){
        
        doITitems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

 
        tableView.reloadData()
    }

}
//MARK: - 5. Searchbar Functions
    
//extension DoITViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request:NSFetchRequest<Item> = Item.fetchRequest()
//
//      let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor (key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//
//            }
//
//
//        }
//    }
//}


