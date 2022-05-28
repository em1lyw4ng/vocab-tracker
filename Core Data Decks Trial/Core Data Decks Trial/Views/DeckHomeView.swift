import UIKit
import CoreData

var cardList = [Card]()

class DeckHomeView: UIViewController {
    
    var deck: Deck? //deck should get passed over to view controller

    @IBOutlet weak var deckNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        cardList = DataManager.shared.cards() //?
        tableView.reloadData()
        
        // set DeckName and cards (doesn't do this)
        if let deck = deck {
            deckNameLabel.text = deck.title
            
            if let allCards = deck.cards?.allObjects as? [Card] {
                cardList = allCards
            }
        }
    }
}

extension DeckHomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cardCell = tableView.dequeueReusableCell(withIdentifier: "cardCellID", for: indexPath) as! CardCell
        
        let thisCard = cardList[indexPath.row]
        
        cardCell.termLabel.text = thisCard.term
        cardCell.defLabel.text = thisCard.definition
        cardCell.pronunLabel.text = thisCard.pronunciation
        
        return cardCell
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editCard", sender: self)
    }
     */
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editCard") {
            
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            
            let cardDetail = segue.destination as? CreateCardView
            
            let selectedCard: Card!
            selectedCard = cardList[indexPath.row]
            
            cardDetail!.selectedCard = selectedCard
            
            //tableView.deselectRow(at: indexPath, animated: true)
        }
        // else statement
    }
     */
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    

}

