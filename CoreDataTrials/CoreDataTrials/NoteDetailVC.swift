import UIKit
import CoreData

class NoteDetailVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext // now have context for which we want to save our entity
       
        // entity
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        // to be inserted into context
        let newNote = Note(entity: entity!, insertInto: context)
        
        newNote.id = noteList.count as NSNumber // in order of incrementing id
        newNote.title = titleTF.text
        newNote.desc = descTV.text
        do {
            try context.save()
            noteList.append(newNote) // add to memory noteList
            navigationController?.popViewController(animated: true) // go back to previous view controller
        }
        catch {
            print("context save error")
        }
        
    }
    
}
