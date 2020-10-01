import XCTest
import Quick
import Nimble
@testable import AssignmentTask

class ServiceLocatorTests: QuickSpec {

    override func spec() {
        describe("registering services") {
            it("returns equivalent service after registering") {
                let locator = ServiceLocator.shared
                let service = MockServiceA()
                locator.registerService(service, forKey: "abc")
                let actual: MockService = locator.service(forKey: "abc", orCreate: self.mockServiceB())
                expect(actual).to(beAnInstanceOf(MockServiceA.self))
            }
            it("returns updated service") {
                let locator = ServiceLocator.shared
                let serviceA = MockServiceA()
                locator.registerService(serviceA, forKey: "abc")
                let actualA: MockService = locator.service(forKey: "abc", orCreate: self.mockServiceB())
                expect(actualA).to(beAnInstanceOf(MockServiceA.self))
                let serviceB = MockServiceB()
                locator.registerService(serviceB, forKey: "abc")
                let actualB: MockService = locator.service(forKey: "abc", orCreate: self.mockServiceA())
                expect(actualB).to(beAnInstanceOf(MockServiceB.self))

            }
        }

    }

    private func mockServiceA() -> MockService {
        return MockServiceA()
    }

    private func mockServiceB() -> MockService {
        return MockServiceB()
    }

}

private protocol MockService {

}

private struct MockServiceA: MockService {

}

private struct MockServiceB: MockService {

}

