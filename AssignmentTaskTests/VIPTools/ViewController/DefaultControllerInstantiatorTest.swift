import XCTest
@testable import AssignmentTask

class DefaultControllerInstantiatorTest: XCTestCase {
    

    func testInstantiatesNibViewController() {
        let instantiator = DefaultControllerInstantiator.nib(DefaultControllerNamingStrategy.namedAfter(IndiaWorldCupWinnerViewController.self))
        let controller: IndiaWorldCupWinnerViewController = instantiator.instantiate()
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.label)
    }
    
    func testFailsToInstantiateNibViewControllerThatDoesntExist() {
        let instantiator = DefaultControllerInstantiator.nib(DefaultControllerNamingStrategy.namedExplicitly("FooBar"))
        SwiftTryCatch.try({
            instantiator.instantiate().loadViewIfNeeded()
            XCTAssertFalse(false, "Should have thrown an exception")
        }, catch: { (error) in
            XCTAssertEqual("NSInternalInconsistencyException", error.name.rawValue)
        })
    }
    
    func testInstantiatesStoryboardViewController() {
        let instantiator = DefaultControllerInstantiator.storyboard(DefaultControllerNamingStrategy.namedAfterWithoutViewControllerSuffix(IndiaWorldCupLooserViewController.self))
        let controller: IndiaWorldCupLooserViewController = instantiator.instantiate()
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.toggle)
    }
    
    func testFailsToInstantiatesStoryboardViewController() {
        let instantiator = DefaultControllerInstantiator.storyboard(DefaultControllerNamingStrategy.namedExplicitly("FooBar"))
        SwiftTryCatch.try({
            instantiator.instantiate().loadViewIfNeeded()
            XCTAssertFalse(false, "Should have thrown an exception")
        }, catch: { (error) in
            XCTAssertEqual("NSInvalidArgumentException", error.name.rawValue)
        })
    }

}
