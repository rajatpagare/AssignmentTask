import Foundation

protocol ObservationCoordinatorDelegate: class {

    func observerAdded(_ observer: Observer)
    func observerRemoved(_ observer: Observer)
    func observersPurged()

}

extension ObservationCoordinatorDelegate {

    func observerAdded(_ observer: Observer) { }
    func observerRemoved(_ observer: Observer) { }
    func observersPurged() { }

}

class ObservationCoordinator: Observable {

    private var observations = Set<Observation>()
    private var operationQueue = DispatchQueue(label: "\(type(of: ObservationCoordinator.self)) Operation queue", qos: .utility)
    private var observerQueue = DispatchQueue(label: "\(type(of: ObservationCoordinator.self)) Observer queue", qos: .utility, attributes: .concurrent)
    weak var delegate: ObservationCoordinatorDelegate?

    func addObserver(_ observer: Observer) {
        _ = operationQueue.sync {
            self.observations.insert(Observation(observer: observer))
        }
        delegate?.observerAdded(observer)
    }

    func removeObserver(_ observer: Observer) {
        _ = operationQueue.sync {
            self.observations.remove(Observation(observer: observer))
        }
        delegate?.observerRemoved(observer)
    }

    func purgeObservers() {
        operationQueue.async {
            let toRemove = self.observations.filter { $0.isPurgeable() }
            self.observations.subtract(toRemove)
        }
        delegate?.observersPurged()
    }

    func broadcast(topic: ObservableTopic) {
        operationQueue.async {
            self.observations.forEach { observation in
                self.observerQueue.async {
                    observation.notify(topic: topic)
                }
            }
        }
        purgeObservers()
    }

    func hasObservation(forObserver observer: Observer) -> Bool {
        var exists = false
        operationQueue.sync {
            exists = observations.contains(Observation(observer: observer))
        }
        return exists
    }

    func liveObserverCount() -> Int {
        purgeObservers()
        var count = 0
        operationQueue.sync {
            count = observations.count
        }
        return count
    }

    private struct Observation: Hashable {
        private let identifier: ObjectIdentifier
        weak var observer: Observer?

        init(observer: Observer) {
            self.identifier = ObjectIdentifier(observer)
            self.observer = observer
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }

        func isPurgeable() -> Bool {
            return observer == nil
        }

        func notify(topic: ObservableTopic) {
            observer?.changes(forTopic: topic)
        }

        static func == (lhs: Observation, rhs: Observation) -> Bool {
            return lhs.identifier == rhs.identifier
        }

    }

}
