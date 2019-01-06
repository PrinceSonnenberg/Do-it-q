//
//  ViewController.swift
//  Do it
//
//  Created by Prince Sonnenberg on 2019/01/03.
//  Copyright © 2019 Prince Sonnenberg. All rights reserved.
//

import UIKit

class DoITViewController: UITableViewController  {
    
    // create demo tableview data
    
   var itemArray  = ["Buy Dog food", "Create Website", "Call Doug"]
 
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let items = defaults.array(forKey: "TodoListArray") as? [String]   {
            
            itemArray = items
            
        }
      
    }
    
    //MARK - 1. Create TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    cell.textLabel?.text = itemArray[indexPath.row]
    
    return cell
    
    
    }

    
    // MARK -2. Create Tableview Delegate Methods (to detect which row is selected using didselect) Then we establish initial cell behaviour
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // print(itemArray[indexPath.row]) // gets item out of hardcoded array data
        
        
        //implement checkmark in code as opposed do default checks via settings
       
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // highlight selection in gray for a second
        tableView.deselectRow(at: indexPath, animated: true)
    
        
    }
    
    //MARK - 3. Add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New DoIt item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user presses add item on uialert
            
         self.itemArray.append(textField.text!)
            
         self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
         self.tableView.reloadData()
            
        }
        
        alert.addTextField{( alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
         
    }
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
        
        
        
    }
    
}

