import UIKit

class UserDetailsConfigurator: ControllerConfigurator {

    func configure(_ target: UserDetailsViewController) {
        let interactor = UserDetailsInteractor()
        let presenter = UserDetailsPresenter()
        let router = UserDetailsRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }

}
