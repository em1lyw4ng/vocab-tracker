import UIKit

class TestSettingsView: UIViewController {
    
    @IBOutlet weak var modeControl: UISegmentedControl!
    @IBOutlet weak var timeControl: UISlider!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var mode: String?
    var limit: Int?
    var deck: Deck?
    
    @IBOutlet weak var deckMustLabel: UILabel!
    @IBOutlet weak var toBeginLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func selectMode(_ sender: Any) {
        let selected = modeControl.selectedSegmentIndex
        if(selected == 0) {
            mode = "definition"
        }
        else {
            mode = "pronunciation"
        }
    }
    
    @IBAction func selectLimit(_ sender: UISlider) {
        secondsLabel.text = "\(Int(sender.value)) seconds"
        limit = Int(sender.value)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(deck?.cards?.allObjects.count ?? 0 < 4) {
            deckMustLabel.text = "*Deck must have AT LEAST"
            numLabel.text = "4 cards"
            toBeginLabel.text = "to begin a test"
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toTesting") {
            let dest = segue.destination as! TestView
            dest.mode = mode
            dest.limit = limit
            dest.deck = deck
        }
    }
}
