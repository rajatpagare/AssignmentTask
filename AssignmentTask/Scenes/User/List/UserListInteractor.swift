import UIKit

protocol UserListBusinessLogic {
    func fetchUsers(request: UserList.FetchUser.Request)
    func fetchSelectedUser(request: UserList.FetchSelectedUser.Request)
    func favoriteUser(request: UserList.FavoriteUser.Request)
}

protocol UserListDataStore {
    var selectedUser: User? { get set }
}

class UserListInteractor: UserListDataStore {
    var presenter: UserListPresentationLogic?
    let userService = ServiceLocator.shared.userService()
    var selectedUser: User?
    var users: [User] = []
    var favoriteUserDataService = ServiceLocator.shared.favoriteUserDataService()
}

extension UserListInteractor: UserListBusinessLogic {

    func fetchUsers(request: UserList.FetchUser.Request) {
        favoriteUserDataService.addObserver(self)
        userService.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                let updatedUsers = self?.updateFavoriteUsers(users) ?? []
                self?.users = updatedUsers
                self?.presenter?.presentUsers(response: .init(users: updatedUsers))
            case .failure(let error):
                self?.presenter?.presentError(response: .init(message: error.localizedDescription))
            }
        }
    }

    func fetchSelectedUser(request: UserList.FetchSelectedUser.Request) {
        selectedUser = users.first(where: { $0.id == request.identifier })
        presenter?.presentSelectedUser(response: .init())
    }

    private func updateFavoriteUsers(_ users: [User]) -> [User] {
        var updatedUsers: [User] = []
        let favoriteUsers = favoriteUserDataService.getFavoriteUserIdentifiers()
        for indice in users.indices {
            var user = users[indice]
            user.updateFavorite(false)
            if favoriteUsers.contains(user.id) {
                user.updateFavorite(true)
            }
            updatedUsers.append(user)
        }
        return updatedUsers
    }

    func favoriteUser(request: UserList.FavoriteUser.Request) {
        guard let user = users.first(where: { $0.id == request.identifier }) else { return }
        if user.favorite {
            favoriteUserDataService.removeFavoriteUser(identifier: request.identifier)
        } else {
            favoriteUserDataService.setFavoriteUser(identifier: request.identifier)
        }
    }
}

extension UserListInteractor: Observer {

    func changes(forTopic topic: ObservableTopic) {
        if let topic = topic as? FavoriteUserTopic {
            switch topic {
            case .userUpdated:
                let updatedUsers = updateFavoriteUsers(users)
                users = updatedUsers
                self.presenter?.presentUsers(response: .init(users: updatedUsers))
            }
        }
    }
}
