import Foundation

protocol FavoriteUserDataService: UsesObservationCoordinator {
    func getFavoriteUserIdentifiers() -> [Int]
    func setFavoriteUser(identifier: Int)
    func removeFavoriteUser(identifier: Int)
}

enum FavoriteUserTopic: ObservableTopic {
    case userUpdated([Int])
}

struct FavoriteUserDataStore: FavoriteUserDataService {

    let coordinator = ObservationCoordinator()
    let userDefaults: UserDefaults

    func getFavoriteUserIdentifiers() -> [Int] {
        return userDefaults.favoriteUsers
    }

    func setFavoriteUser(identifier: Int) {
        var favoriteUsers = userDefaults.favoriteUsers
        guard !favoriteUsers.contains(identifier) else { return }
        favoriteUsers.append(identifier)
        userDefaults.favoriteUsers = favoriteUsers
        broadcast(topic: FavoriteUserTopic.userUpdated(favoriteUsers))
    }

    func removeFavoriteUser(identifier: Int) {
        var favoriteUsers = userDefaults.favoriteUsers
        guard let index = favoriteUsers.firstIndex(of: identifier) else { return }
        favoriteUsers.remove(at: index)
        userDefaults.favoriteUsers = favoriteUsers
        broadcast(topic: FavoriteUserTopic.userUpdated(favoriteUsers))
    }
}

private extension UserDefaults {
    private var favoriteUsersKey: String {
        return "favoriteUser"
    }

    var favoriteUsers: [Int] {
        get {
            return array(forKey: favoriteUsersKey) as? [Int] ?? []
        }
        set {
            set(newValue, forKey: favoriteUsersKey)
        }
    }
}
