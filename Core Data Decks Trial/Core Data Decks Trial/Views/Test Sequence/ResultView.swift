import UIKit

class ResultView: UIViewController {
    var incorrect = [Question]()
    var correct = [Question]()
    var mode: String?
    var deck: Deck?
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var hiddenSections = [Int]()
    var tableViewData = [[Question]]()
    
    @IBAction func returnAndSave(_ sender: Any) {
        var incorrectTerms = [String]()
        var correctTerms = [String]()
        
        for ans in incorrect {
            incorrectTerms.append(ans.term)
        }
        
        for ans in correct {
            correctTerms.append(ans.term)
        }
       
        //DataManager.shared.test(type: mode!, incorrect: incorrectTerms, correct: correctTerms, deck: deck!)
        //DataManager.shared.save() // for later development: statistics
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradeLabel.text = "\(Int(correct.count)) / \(Int(incorrect.count + correct.count)) "
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewData.append(correct)
        tableViewData.append(incorrect)
    }
}

extension ResultView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return self.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row].term
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        var sectionTitle: String = ""
        
        if section == 0 {
            sectionTitle = "Correct"
        }
        
        else {
            sectionTitle = "Incorrect"
        }
        
        sectionButton.setTitle(sectionTitle, for: .normal)
        
        sectionButton.backgroundColor = .systemOrange
        
        sectionButton.tag = section
        
        sectionButton.addTarget(self, action: #selector(self.hideSection(sender:)), for: .touchUpInside)
        
        return sectionButton
    }
    
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.tableViewData[section].count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            return indexPaths
        }
    }
}
