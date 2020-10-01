import Foundation

extension ServiceLocator {

    private var serviceKey: String {
        return String(describing: FavoriteUserDataStore.self)
    }

    func registerFavoriteUserDataService(_ service: FavoriteUserDataService) {
        registerService(service, forKey: serviceKey)
    }

    func favoriteUserDataService() -> FavoriteUserDataService {
        return service(forKey: serviceKey, orCreate: defaultFavoriteUserDataService())
    }

    private func defaultFavoriteUserDataService() -> FavoriteUserDataStore {
        return FavoriteUserDataStore(userDefaults: .standard)
    }
}
