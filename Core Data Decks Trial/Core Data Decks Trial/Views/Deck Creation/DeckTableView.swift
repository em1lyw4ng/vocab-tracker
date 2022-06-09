import UIKit

var deckList = [Deck]()

class DeckTableView: UITableViewController {
    //let context  = DataManager.shared.persistentContainer
    
    /* Unwind segue but changed modal sheet to pushed VC
    viewWillAppear didn't get called twice
    @IBAction func unwind( _ unwindSegue: UIStoryboardSegue) {
    }
     */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deckCell = tableView.dequeueReusableCell(withIdentifier: "deckCellID", for: indexPath) as! DeckCell
        
        let thisDeck = deckList[indexPath.row]
        
        deckCell.titleLabel.text = thisDeck.title
        deckCell.subjLabel.text = thisDeck.subject
        
        return deckCell
        }
    
    // persist CoreData into TableView
    override func viewDidLoad() {
        deckList = DataManager.shared.decks()
        tableView.reloadData()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deckList.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDeckDetail") {
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                return
            }
            let selected = deckList[indexPath.row]
            let dest = segue.destination as! DeckHomeView
            dest.deck = selected
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
        
            // Which deck to remove
            let deckToRemove = deckList[indexPath.row]
            
            // Remove the deck
            DataManager.shared.persistentContainer.viewContext.delete(deckToRemove)
            
            // Save data
            DataManager.shared.save()
            
            // Refetch data
            deckList = DataManager.shared.decks()
        }
        // Return swipe actions
        tableView.reloadData()
        return UISwipeActionsConfiguration(actions: [action])
    }
}
