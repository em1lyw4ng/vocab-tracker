import UIKit
import CoreData

var noteList = [Note]() // public so can be accessed by other classes (such as NoteDetailViewController

class NoteTableView: UITableViewController {
    var firstLoad = true
    
    override func viewDidLoad() {
        if(firstLoad) {
            firstLoad = false // no longer first load
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note") // request to get entity
            
            do {
                // try fetching array of entities
                let results:NSArray = try context.fetch(request) as NSArray
                
                // populate with array from core  data?
                for result in results {
                    let note = result as! Note
                    noteList.append(note)
                }
            }
            catch {
                print("fetch failed")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // declare cell
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell // using identifier (which have to set as the variable withIdentifier name in the Identifier field in the cell storyboard object (5th tab)
        
        let thisNote: Note!
        // get current row out of tableview
        thisNote = noteList[indexPath.row]
        
        noteCell.titleLabel.text = thisNote.title
        noteCell.descLabel.text = thisNote.desc
        
        return noteCell
    }
    
    
    // overriding number of rows in section method
    override func numberOfSections(in tableView: UITableView) -> Int {
        return noteList.count
    }
    
    // overriding viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
