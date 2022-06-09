import UIKit
import CoreData

class CreateCardView: UIViewController {
    
    var deck: Deck?
    
    @IBOutlet weak var termLabel: UITextField!
    @IBOutlet weak var defLabel: UITextField!
    @IBOutlet weak var pronunLabel: UITextField!
    
    var selectedCard : Card? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if(selectedCard != nil) {
            termLabel.text = selectedCard?.term
            defLabel.text = selectedCard?.definition
            pronunLabel.text = selectedCard?.pronunciation
        }
    }
    
    @IBAction func saveCardAction(_ sender: Any) {
        if(selectedCard == nil) {
            guard let deck = deck else {
                return
            }
                    
            guard let term = termLabel.text else {
                print("Invalid term")
                return
            }
            
            guard let definition = defLabel.text else {
                print("Invalid definition or no definition")
                return
            }
            
            guard let pronunciation = pronunLabel.text else {
                print("Invalid pronunciation or no pronunciation")
                return
            }
            
            // save new card
            let card = DataManager.shared.card(term: term, definition: definition, pronunciation: pronunciation, deck: deck)
            cardList.append(card)
            DataManager.shared.save()
            navigationController?.popViewController(animated: true)
        }
        else {
            let cards = DataManager.shared.cards()
            for card in cards {
                if (card == selectedCard) {
                    card.term = termLabel.text
                    card.definition = defLabel.text
                    card.pronunciation = pronunLabel.text
                    DataManager.shared.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
