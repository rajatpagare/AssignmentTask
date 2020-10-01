import UIKit
import MessageUI

protocol UserListRoutingLogic {
    func routeToDetails()
    func routeToDisplayError(message: String)
}

protocol UserListDataPassing {
    var dataStore: UserListDataStore? { get }
}

class UserListRouter: NSObject, UserListDataPassing {
    weak var viewController: UserListViewController?
    var dataStore: UserListDataStore?
}

extension UserListRouter: UserListRoutingLogic {

    func routeToDetails() {
        guard let selectedUser = dataStore?.selectedUser else { return }
        let vc = DefaultControllerFactory().newController(configuredUsing: UserDetailsConfigurator())
        var targetDS = vc.router?.dataStore
        targetDS?.selectedUser = selectedUser
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func routeToDisplayError(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
