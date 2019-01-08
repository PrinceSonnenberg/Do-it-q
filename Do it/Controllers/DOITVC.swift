//
//  ViewController.swift
//  Do it
//
//  Created by Prince Sonnenberg on 2019/01/03.
//  Copyright © 2019 Prince Sonnenberg. All rights reserved.
//

import UIKit

class DoITViewController: UITableViewController  {
    
    var itemArray  = [Item]()

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        loadItems()
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
        
        

            return cell
    }
    

    // MARK -2. Create Tableview Delegate Methods (to detect which row is selected using didselect) Then we establish initial cell behaviour
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
    
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
        
         self.saveItems()
        
        }
    
        alert.addTextField{( alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
         
    }
        alert.addAction(action)
        
        self.present(alert,animated: true, completion: nil)
        
        
        
        }

 //Mark - Model manipulation functions
    
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("error encoding, \(error)")
        }
        
        self.tableView.reloadData()
        
        }
    
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
             itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                
                print(error)
                
            }
        }
        
    }
    
        
    }
    


