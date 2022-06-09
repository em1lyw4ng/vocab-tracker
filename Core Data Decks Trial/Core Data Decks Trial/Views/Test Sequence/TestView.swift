import UIKit

struct Question {
    let term: String
    let answers: [Answer]
}

struct Answer : Equatable {
    let text: String
    let correct: Bool
}

class TestView: UIViewController {
    var mode: String?
    var limit: Int?
    var deck: Deck?
    
    private var cards = [Card]()
    var testQuestions = [Question]()
    
    var index = 0
    var answerSelected = false
    var isCorrectAnswer = false
    
    var incorrect = [Question]()
    var correct = [Question]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        cards = deck?.cards?.allObjects as! [Card]
        setupQuestions(cards: cards)
        testQuestions.shuffle()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    private func setupQuestions(cards: [Card]) {
        for card in cards {
            testQuestions.append(Question(term: card.term ?? "", answers: setupAnswers(card: card, cards: cards, mode: mode ?? "definition")))
        }
    }
    
    private func setupAnswers(card: Card, cards: [Card], mode: String) -> [Answer] {
        var answers : [Answer] = []
        
        for thisCard in cards {
            if (mode == "definition") {
                if (thisCard.term == card.term) {
                    answers.append(Answer(text: thisCard.definition!, correct: true))
                }
                else {
                    answers.append(Answer(text:thisCard.definition!, correct: false))
                }
            }
            
            if (mode == "pronunciation") {
                if (thisCard.term == card.term) {
                    answers.append(Answer(text: thisCard.pronunciation!, correct: true))
                }
                else {
                    answers.append(Answer(text:thisCard.definition!, correct: false))
                }
            }
        }
        return processAnswers(answers: answers)
    }
    
    private func processAnswers(answers: [Answer]) -> [Answer] {
        var processed: [Answer] = []
        
        guard let correct = answers.first(where: {$0.correct == true}) else {
            return [Answer(text: "DNE", correct: true)]
        }
        processed.append(correct)
        
        // other 3 answers that are not correct (filter)
        let otherAnswers = answers.filter({$0.correct != true}).shuffled().prefix(3)

        for ans in otherAnswers{
            processed.append(ans)
        }
        return processed.shuffled()
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool {
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
    }
    
    // and checks as well as appends to incorrect/correct
    @IBAction func nextQuestion(_ sender: Any) {
        if answerSelected && index < (self.testQuestions.count) - 1 {
            index += 1
            collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)}
        else if !answerSelected {
            return
        }
        else if answerSelected && !(index < (self.testQuestions.count) - 1) {
            // check last
            if isCorrectAnswer && answerSelected {
                correct.append(testQuestions.last!)
            }
            
            else if !isCorrectAnswer && answerSelected {
                incorrect.append(testQuestions.last!)
                for ans in incorrect {
                    print(ans)
                }
            }
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "resultViewID") as? ResultView else {return}
            vc.correct = correct
            vc.incorrect = incorrect
            vc.mode = mode
            vc.deck = deck
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TestView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testcollectionviewcell", for: indexPath) as? TestCollectionView else {
            return TestCollectionView()
        }
        cell.setValues = testQuestions[indexPath.row]
        cell.selectedOption = {[weak self] isCorrect in
            self?.answerSelected = true
            self?.isCorrectAnswer = isCorrect
        }
        
        if isCorrectAnswer && answerSelected {
            correct.append(testQuestions[indexPath.row - 1])
        }
        
        else if !isCorrectAnswer && answerSelected {
            incorrect.append(testQuestions[indexPath.row - 1])
        }
        
        answerSelected = false
        
        return cell
    }
    
    
}
