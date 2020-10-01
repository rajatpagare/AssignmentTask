import Foundation

protocol UsesObservationCoordinator: Observable {

    var coordinator: ObservationCoordinator { get }

}

extension UsesObservationCoordinator {

    func addObserver(_ observer: Observer) {
        coordinator.addObserver(observer)
    }

    func removeObserver(_ observer: Observer) {
        coordinator.removeObserver(observer)
    }

    func broadcast(topic: ObservableTopic) {
        coordinator.broadcast(topic: topic)
    }

    func purgeObservers() {
        coordinator.purgeObservers()
    }

}
