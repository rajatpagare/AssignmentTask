import Foundation

protocol Observable {

    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func broadcast(topic: ObservableTopic)
    func purgeObservers()

}

protocol Observer: class {

    func changes(forTopic topic: ObservableTopic)
}

protocol ObservableTopic {

}
