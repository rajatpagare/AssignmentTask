import XCTest
@testable import AssignmentTask

class ObservationCoordinatorTests: XCTestCase {

    func testObserverAdded() {
        let coordinator = ObservationCoordinator()
        let observerA = MockObserver()
        coordinator.addObserver(observerA)
        XCTAssertTrue(coordinator.hasObservation(forObserver: observerA))
        XCTAssertEqual(1, coordinator.liveObserverCount())

        let observerB = MockObserver()
        coordinator.addObserver(observerB)
        XCTAssertTrue(coordinator.hasObservation(forObserver: observerB))
        XCTAssertEqual(2, coordinator.liveObserverCount())
    }

    func testSameObserverAddedOnce() {
        let coordinator = ObservationCoordinator()
        let observerA = MockObserver()
        coordinator.addObserver(observerA)
        coordinator.addObserver(observerA)
        coordinator.addObserver(observerA)
        XCTAssertTrue(coordinator.hasObservation(forObserver: observerA))
        XCTAssertEqual(1, coordinator.liveObserverCount())
    }

    func testObserverRemoved() {
        let coordinator = ObservationCoordinator()
        let observerA = MockObserver()
        coordinator.addObserver(observerA)
        let observerB = MockObserver()
        coordinator.addObserver(observerB)

        XCTAssertEqual(2, coordinator.liveObserverCount())

        coordinator.removeObserver(observerB)

        XCTAssertTrue(coordinator.hasObservation(forObserver: observerA))
        XCTAssertFalse(coordinator.hasObservation(forObserver: observerB))
        XCTAssertEqual(1, coordinator.liveObserverCount())

        coordinator.removeObserver(observerA)
        XCTAssertFalse(coordinator.hasObservation(forObserver: observerA))
        XCTAssertFalse(coordinator.hasObservation(forObserver: observerB))
        XCTAssertEqual(0, coordinator.liveObserverCount())
    }

    func testObserversPurged() {
        let coordinator = ObservationCoordinator()
        var observerA: Observer? = MockObserver()
        coordinator.addObserver(observerA!)
        let observerB = MockObserver()
        coordinator.addObserver(observerB)

        coordinator.purgeObservers()
        XCTAssertEqual(2, coordinator.liveObserverCount())

        observerA = nil
        coordinator.purgeObservers()
        XCTAssertEqual(1, coordinator.liveObserverCount())
        XCTAssertTrue(coordinator.hasObservation(forObserver: observerB))
    }

    func testNotifiesDelegateWhenObserverAdded() {
        let coordinator = ObservationCoordinator()
        let delegate = MockObservationCoordinatorDelegate()
        coordinator.delegate = delegate
        let observer: Observer = MockObserver()
        coordinator.addObserver(observer)

        wait(for: [delegate.addedExpectation], timeout: 1)
        XCTAssertTrue(observer === delegate.addedObserver)
    }

    func testNotifiesDelegateWhenObserverRemoved() {
        let coordinator = ObservationCoordinator()
        let delegate = MockObservationCoordinatorDelegate()
        coordinator.delegate = delegate
        let observer: Observer = MockObserver()
        coordinator.addObserver(observer)
        coordinator.removeObserver(observer)

        wait(for: [delegate.removedExpectation], timeout: 1)
        XCTAssertTrue(observer === delegate.removedObserver)
    }

    func testNotifiesDelegateWhenObserversPurged() {
        let coordinator = ObservationCoordinator()
        let delegate = MockObservationCoordinatorDelegate()
        coordinator.delegate = delegate
        var observer: Observer? = MockObserver()
        coordinator.addObserver(observer!)
        observer = nil

        coordinator.purgeObservers()

        wait(for: [delegate.purgedExpectation], timeout: 1)
    }
}
