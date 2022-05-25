import UIKit

var deckList = [Deck]()

class DeckTableView: UITableViewController {
    
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
    
}
