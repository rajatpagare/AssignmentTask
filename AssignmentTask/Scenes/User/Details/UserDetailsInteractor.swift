import UIKit

protocol UserDetailsBusinessLogic {
    func fetchUserDetails(request: UserDetails.FetchDetails.Request)
    func favoriteUser(request: UserDetails.FavoriteUser.Request)
}

protocol UserDetailsDataStore {
    var selectedUser: User? { get set }
}

class UserDetailsInteractor: UserDetailsDataStore {
    var presenter: UserDetailsPresentationLogic?
    let userService = ServiceLocator.shared.userService()
    var selectedUser: User?
    private var favoriteUserDataService = ServiceLocator.shared.favoriteUserDataService()
}

extension UserDetailsInteractor: UserDetailsBusinessLogic {

    func fetchUserDetails(request: UserDetails.FetchDetails.Request) {
        guard let user = selectedUser else { return }
        presenter?.presentUserDetails(response: .init(user: user))
    }

    func favoriteUser(request: UserDetails.FavoriteUser.Request) {
        guard var user = selectedUser else { return }
        if user.favorite {
            favoriteUserDataService.removeFavoriteUser(identifier: user.id)
        } else {
            favoriteUserDataService.setFavoriteUser(identifier:  user.id)
        }
        user.updateFavorite(!user.favorite)
        presenter?.presentFavoriteUpdate(response: .init(favorite: user.favorite))
    }

}
