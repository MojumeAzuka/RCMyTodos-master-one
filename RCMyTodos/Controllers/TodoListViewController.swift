

import UIKit

class TodoListViewController: UITableViewController {
    
    //itemArray is an mutable array of strings that wil be used to populate the tableview cells
//    var itemArray = ["Learn Swift programming", "Learn UIKit", "Make mini UIKit project", "Learn SwiftUI", "Make mini SwiftUI project", "Learn Advanced Swift programming"]
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    //
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Learn Swift programming"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Learn UIKit"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Make mini UIKit project"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Learn SwiftUI"
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "Make mini SwiftUI project"
        itemArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title = "Learn Advanced Swift programming"
        itemArray.append(newItem6)

//When our app loads up we use our user defaults to possibly pull up our array
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            //if the array pull is succesfull, the the item array is set to equal items
            itemArray = items
        }
    }
    
    
    
    
    //MARK - Tableview Datasource Methods
    //This method is for determining the number of rows that will be outputed on screen
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //This method is for determining what should be outputted to each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // This line creates/ recreates a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        //This line changes the textlabel's text property for the cell object by using the title property of the current itemArray index
        cell.textLabel?.text = item.title
        
        /*These lines determine whether or not there are checkmarks accesories on each cell, if a cell doesn't have a check mark
         and is then selected, a check mark is added. But if the reverse is the case, then the checkmark is removed. By default the done property of itemArray array elements is false. */
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    
    
    
    //MARK - Tableview Delegate Methods
    //This method is for handling the selection of cells and its effects
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        /*These lines determine whether or not there are checkmarks accesories on each cell, if a cell doesn't have a check mark
         and is then selected, a check mark is added. But if the reverse is the case, then the checkmark is removed. By default the done property of itemArray array elements is false. */
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        //reloadData forces the tableView to recall it data source
        tableView.reloadData()

        //The deselectRow property allows the cells to flash gray breifly and then go back to white
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
            //This creates a new element for the itemArray array
            let newItem = Item()
            
            //This sets the title property for the new element
            newItem.title = textField.text!
            
            //This appends a new element to the itemArray array
            self.itemArray.append(newItem)
            
            //This sets into the user defaults using the key TodoListArray
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
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

