import UIKit
import MessageUI

protocol UserDetailsRoutingLogic { }

protocol UserDetailsDataPassing {
    var dataStore: UserDetailsDataStore? { get }
}

class UserDetailsRouter: NSObject, UserDetailsDataPassing {
    weak var viewController: UserDetailsViewController?
    var dataStore: UserDetailsDataStore?
}

extension UserDetailsRouter: UserDetailsRoutingLogic { }
