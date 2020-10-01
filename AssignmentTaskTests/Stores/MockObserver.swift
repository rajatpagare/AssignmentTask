import Foundation
import XCTest
@testable import AssignmentTask

class MockObserver: Observer {

    let changesExpectation = XCTestExpectation(description: "changes called")
    var changesTopic: ObservableTopic?

    func changes(forTopic topic: ObservableTopic) {
        changesTopic = topic
        changesExpectation.fulfill()
    }


}
