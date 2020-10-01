import Foundation
import XCTest
@testable import AssignmentTask

class MockObservationCoordinatorDelegate: NSObject, ObservationCoordinatorDelegate {

    let addedExpectation = XCTestExpectation(description: "added called")
    var addedObserver: Observer?
    let removedExpectation = XCTestExpectation(description: "removed called")
    var removedObserver: Observer?
    let purgedExpectation = XCTestExpectation(description: "purged called")

    func observerAdded(_ observer: Observer) {
        addedObserver = observer
        addedExpectation.fulfill()
    }

    func observerRemoved(_ observer: Observer) {
        removedObserver = observer
        removedExpectation.fulfill()
    }

    func observersPurged() {
        purgedExpectation.fulfill()
    }

}
