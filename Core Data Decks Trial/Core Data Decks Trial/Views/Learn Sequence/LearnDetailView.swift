import UIKit

class LearnDetailView: UIViewController {
    static let cardCornerRadius: CGFloat = 25
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    var deck: Deck?
    var isDefinition: Bool?
    
    var term: String?
    var definition: String?
    var pronunciation: String?
    var pageIndex: Int?
    var showingBackside: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = LearnDetailView.cardCornerRadius
        card.layer.masksToBounds = true
        textLabel.text = term
        showingBackside = false
    }
    
    // tap action
    @IBAction func showAction(_ sender: Any) {
        if(showingBackside ?? true) {
            textLabel.text = term
            showingBackside = false
            return
        }
        
        if(isDefinition ?? true && !(showingBackside ?? false)) {
            textLabel.text = definition
            showingBackside = true
            return
        }
        
        if(!(isDefinition ?? false) && !(showingBackside ?? false)) {
            textLabel.text = pronunciation
            showingBackside = true
            return
        }
    }

}
