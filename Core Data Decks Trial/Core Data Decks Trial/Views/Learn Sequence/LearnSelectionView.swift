import UIKit

class LearnSelectionView: UIViewController {
    var deck: Deck?
    
    // probably prepare segue to pass deck data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toLearnDefinition") {
            let dest = segue.destination as! LearnPageViewController
            dest.deck = deck
            dest.isDefinition = true
        }
        else {
            let dest = segue.destination as! LearnPageViewController
            dest.deck = deck
            dest.isDefinition = false
        }
    }
    
}
