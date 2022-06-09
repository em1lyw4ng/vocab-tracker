import Foundation
import CoreData

// MARK: - Core Data stack
class DataManager {
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Core_Data_Decks_Trial")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // create a Deck object
    func deck(title: String, subject: String) -> Deck {
        let set = Deck(context: persistentContainer.viewContext)
        set.title = title
        set.subject = subject
        return set
    }
    
    // return all Deck objects
    func decks() -> [Deck] {
        let request: NSFetchRequest<Deck> = Deck.fetchRequest()
        
        var fetchedDecks: [Deck] = []
        
        do {
            fetchedDecks = try persistentContainer.viewContext.fetch(request)
        }
        catch {
            print("Error fetching decks")
        }
        return fetchedDecks
    }
    
    // create a Card object
    func card(term: String, definition: String, pronunciation: String, deck: Deck) -> Card {
        let flshcard = Card(context: persistentContainer.viewContext)
        flshcard.term = term
        flshcard.definition = definition
        flshcard.pronunciation = pronunciation
        flshcard.timestamp = Date()
        flshcard.deck = deck
        return flshcard
    }
    
    // return all Card objects
    func cards() -> [Card] {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        
        var fetchedCards: [Card] = []
        
        do {
            fetchedCards = try persistentContainer.viewContext.fetch(request)
        }
        catch {
            print("Error fetching cards")
        }
        return fetchedCards
    }
    
    // create a Test object
    func test(type: String, incorrect: [String], correct: [String], deck: Deck) -> Test {
        let tst = Test(context: persistentContainer.viewContext)
        tst.type = type
        tst.dateTaken = Date() //saves current date was created
        tst.incorrect = incorrect
        tst.correct = correct
        tst.deck = deck
        return tst
    }
    
    // return all Test objects
    func tests() -> [Test] {
        let request: NSFetchRequest<Test> = Test.fetchRequest()
        
        var fetchedTests: [Test] = []
        
        do {
            fetchedTests = try persistentContainer.viewContext.fetch(request)
        }
        catch {
            print("Error fetching tests")
        }
        return fetchedTests
    }
    
    // MARK: - Core Data Saving support

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
