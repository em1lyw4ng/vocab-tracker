import UIKit
import CoreData

class CreateDeckView: UIViewController {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var subjLabel: UITextField!
    
    @IBAction func saveNewDeck(_ sender: Any) {
        // instantiate deckTitle, subjTitle
        guard let deckTitle = titleLabel.text else {
            print("Invalid title")
            return
        }
                
        guard let subjTitle = subjLabel.text else {
            print("Invalid subject")
            return
        }
        
        titleLabel.text = ""
        subjLabel.text = ""
        
        // Save new deck
        let deck = DataManager.shared.deck(title: deckTitle, subject: subjTitle)
        deckList.append(deck)
        DataManager.shared.save()
        navigationController?.popViewController(animated: true)
    }
    
    
    /* Unwind segue but changed modal sheet to pushed VC
    @IBAction func unwindToHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
