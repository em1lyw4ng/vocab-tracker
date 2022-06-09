import UIKit

enum SelectedOption {
    case R1
    case R2
    case R3
    case R4
}

class TestCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var termLabel: UILabel!
    
    @IBOutlet weak var R1Button: UIButton!
    @IBOutlet weak var R2Button: UIButton!
    @IBOutlet weak var R3Button: UIButton!
    @IBOutlet weak var R4Button: UIButton!
    
    private var correctAnswer : Int = 0
    
    var setValues: Question? {
        didSet {
            termLabel.text = setValues?.term
            R1Button.setTitle(setValues?.answers[0].text, for: .normal)
            R2Button.setTitle(setValues?.answers[1].text, for: .normal)
            R3Button.setTitle(setValues?.answers[2].text, for: .normal)
            R4Button.setTitle(setValues?.answers[3].text, for: .normal)
            correctAnswer = (setValues?.answers.firstIndex(where: {$0.correct == true}))!
        }
    }
    
    override func prepareForReuse() {
        updateBorder(response: R1Button)
        updateBorder(response: R2Button)
        updateBorder(response: R3Button)
        updateBorder(response: R4Button)
    }
    
    var selectedOption: ((_ selectedAnswer: Bool) -> Void)?
    
    // also checks answer
    @IBAction func selectedR(_ sender: UIButton) {
        var selected: SelectedOption?
        var isCorrect = false
        
        if sender == R1Button {
            selected = .R1
            if(setValues!.answers[correctAnswer] == setValues?.answers[0]) {
                isCorrect = true
            }
        }
        
        if sender == R2Button {
            selected = .R2
            if(setValues!.answers[correctAnswer] == setValues?.answers[1]) {
                isCorrect = true
            }
        }
        
        if sender == R3Button {
            selected = .R3
            if(setValues!.answers[correctAnswer] == setValues?.answers[2]) {
                isCorrect = true
            }
        }
        
        if sender == R4Button {
            selected = .R4
            if(setValues!.answers[correctAnswer] == setValues?.answers[3]) {
                isCorrect = true
            }
        }
        selectedOption!(isCorrect)
        changeBorder(selectedOption: (selected ?? .none)!)
    }
    
    func changeBorder(selectedOption: SelectedOption) {
        switch selectedOption {
        case .R1:
            updateBorder(response: R1Button, borderWidth: 10)
            updateBorder(response: R2Button)
            updateBorder(response: R3Button)
            updateBorder(response: R4Button)
        case .R2:
            updateBorder(response: R2Button, borderWidth: 10)
            updateBorder(response: R1Button)
            updateBorder(response: R3Button)
            updateBorder(response: R4Button)
        case .R3:
            updateBorder(response: R3Button, borderWidth: 10)
            updateBorder(response: R1Button)
            updateBorder(response: R2Button)
            updateBorder(response: R4Button)
        case .R4:
            updateBorder(response: R4Button, borderWidth: 10)
            updateBorder(response: R1Button)
            updateBorder(response: R2Button)
            updateBorder(response: R3Button)
        }
    }
    
    func updateBorder(response: UIButton, borderWidth: CGFloat = 0) {
        response.layer.borderWidth = borderWidth
        response.layer.borderColor = UIColor.purple.cgColor
        response.layer.cornerRadius = 5
    }
    
    
}
