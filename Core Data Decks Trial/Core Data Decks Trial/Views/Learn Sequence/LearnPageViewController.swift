import UIKit

class LearnPageViewController: UIPageViewController {
    var deck: Deck?
    var isDefinition: Bool?

    private var cards = [Card]()
    private var cardsDefinition = [String]()
    private var cardsPronunciation = [String]()
    private var cardsTerms = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        cards = deck?.cards?.allObjects as [Card]
        
        cardsTerms = cards.map { $0.term ?? "" } // get card attributes
        cardsDefinition = cards.map { $0.definition ?? "" }
        cardsPronunciation = cards.map { $0.pronunciation ?? "" }
        setViewControllers([viewControllerForPage(at: 0)] as [UIViewController],  direction: .forward, animated: false, completion: nil)
    }
}

// Page view controller data source 
extension LearnPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? LearnDetailView,
          let pageIndex = viewController.pageIndex,
          pageIndex > 0  else {
            return nil
        }
        return viewControllerForPage(at: pageIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? LearnDetailView,
          let pageIndex = viewController.pageIndex,
          pageIndex + 1 < cards.count else {
            return nil
        }
        return viewControllerForPage(at: pageIndex + 1)
    }
    
    private func viewControllerForPage(at index: Int) -> LearnDetailView {
        let cardViewController: LearnDetailView = self.storyboard?.instantiateViewController(withIdentifier: "learnDetailID") as! LearnDetailView
        
        cardViewController.term = cardsTerms[index] 
        cardViewController.definition = cardsDefinition[index]
        cardViewController.pronunciation = cardsPronunciation[index]
        
        cardViewController.isDefinition = isDefinition
        cardViewController.pageIndex = index
        return cardViewController
    }
    
}
