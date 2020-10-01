import Foundation
import Alamofire

extension ServiceLocator {

    private func userServiceKey() -> String {
        return String(describing: UserService.self)
    }

    func userService() -> UserService {
        return service(forKey: userServiceKey(), orCreate: defaultUserService())
    }

    private func defaultUserService() -> UserService {
        let network = userNetwork()
        return NetworkUserService(network: network)
    }

    private func userNetworkKey() -> String {
        return String(describing: Network.self)
    }

    func userNetwork() -> Network {
        return service(forKey: userNetworkKey(), orCreate: defaultUserNetwork())
    }

    private func defaultUserNetwork() -> Network {
        return AlamofireNetwork(sessionManager: Session(), baseURL: Environment.userApiUrl)
    }
}
