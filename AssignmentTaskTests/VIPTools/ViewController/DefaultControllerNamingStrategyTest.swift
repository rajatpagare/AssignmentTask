import XCTest
@testable import AssignmentTask

class DefaultControllerNamingStrategyTest: XCTestCase {
    

    func testNamedAfterStrategy() {
        XCTAssertEqual("UIViewController", DefaultControllerNamingStrategy.namedAfter(UIViewController.self).name())
        XCTAssertEqual("IndiaWorldCupWinnerViewController", DefaultControllerNamingStrategy.namedAfter(IndiaWorldCupWinnerViewController.self).name())
        XCTAssertEqual("IndiaWorldCupLooserViewController", DefaultControllerNamingStrategy.namedAfter(IndiaWorldCupLooserViewController.self).name())
    }
    
    func testNamedAfterWithoutViewControllerSuffix() {
        XCTAssertEqual("UI", DefaultControllerNamingStrategy.namedAfterWithoutViewControllerSuffix(UIViewController.self).name())
        XCTAssertEqual("IndiaWorldCupWinner", DefaultControllerNamingStrategy.namedAfterWithoutViewControllerSuffix(IndiaWorldCupWinnerViewController.self).name())
        XCTAssertEqual("IndiaWorldCupLooser", DefaultControllerNamingStrategy.namedAfterWithoutViewControllerSuffix(IndiaWorldCupLooserViewController.self).name())
    }
    
    func testNamedExplcitly() {
        XCTAssertEqual("MySpeciallyNameViewController", DefaultControllerNamingStrategy.namedExplicitly("MySpeciallyNameViewController").name())
        XCTAssertEqual("EnglandWorldCupWinners", DefaultControllerNamingStrategy.namedExplicitly("EnglandWorldCupWinners").name())
    }


}
