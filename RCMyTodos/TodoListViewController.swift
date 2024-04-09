

import UIKit

class TodoListViewController: UITableViewController {
    
    //itemArray is an mutable array of strings that wil be used to populate the tableview cells
    var itemArray = ["Learn Swift programming", "Learn UIKit", "Make mini UIKit project", "Learn SwiftUI", "Make mini SwiftUI project"]
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - Tableview Datasource Methods
    //This method is for determining the number of rows that will be outputed on screen
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //This method is for determining what should be outputted to each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // This line creates a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //This line changes the text property of the cell object
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    //This method is for handling the selection of cells
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        /*These lines determine whether or not there are checkmarks on each cell, if a cell doesn't have a check mark
         and is then selected, a check mark is added. But if the reverse is the case, then the checkmark is removed */
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    // MARK - ADD NEW ITEMS
    
//addButtonPressed is a UIBarButtonItem. Its function is adding items to the list.
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //alert is a popup that has a title of "Add New Todo Item"
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        //action is what will happen once the user clicks the add item button on our UIAlert
        let action = UIAlertAction(title: "Add Item", style: .default){(action) in
          
            
            //This appends a new element to the itemArray array
            self.itemArray.append(textField.text!)
            
            //reloadData reloads the info that is shown
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        //present the alert view
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

