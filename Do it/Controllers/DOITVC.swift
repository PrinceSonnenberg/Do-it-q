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
   
    
   var itemArray  = [Item]()
 
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let newItem1 = Item()
        newItem1.title = "Catch Mike"
        itemArray.append(newItem1)

        
        let newItem2 = Item()
        newItem2.title = "Kill Mike"
        itemArray.append(newItem2)

        
       if let items = defaults.array(forKey: "TodoListArray") as? [Item]   {
            
       itemArray = items
        
        }
        
}
    

    //MARK - 1. Create TableView Data Source Methods
    
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
        
        
//        if item.done ==  true {
//            cell.accessoryType = .checkmark
//
//        } else {
//            cell.accessoryType = .none
//
//        }
//
            return cell
    }
    

    // MARK -2. Create Tableview Delegate Methods (to detect which row is selected using didselect) Then we establish initial cell behaviour
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
 
        
        tableView.reloadData()
        // highlight selection in gray for a second
        tableView.deselectRow(at: indexPath, animated: true)
    
    }

    //MARK - 3. Add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New DoIt item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user presses add item on uialert
  
         let newItem = Item()
         newItem.title = textField.text!
            
         self.itemArray.append(newItem)
            
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
