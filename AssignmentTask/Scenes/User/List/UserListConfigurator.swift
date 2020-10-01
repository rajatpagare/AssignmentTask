import UIKit

class UserListConfigurator: ControllerConfigurator {

    func configure(_ target: UserListViewController) {
        let interactor = UserListInteractor()
        let presenter = UserListPresenter()
        let router = UserListRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }

}
