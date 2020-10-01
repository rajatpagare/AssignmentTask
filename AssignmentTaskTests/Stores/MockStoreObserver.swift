import Foundation
@testable import AssignmentTask

class MockStoreObserver<T: ObservableTopic>: Observer {

    var storeTopic: T?
    var invocationCount = 0

    func changes(forTopic topic: ObservableTopic) {
        storeTopic = topic as? T
        invocationCount += 1
    }
}
