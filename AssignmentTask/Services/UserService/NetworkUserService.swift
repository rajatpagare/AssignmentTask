import Foundation

struct NetworkUserService: UserService {
    
    let network: Network
    
    func getUsers(completion: @escaping UserCallback) {
        let request = UserAPI.getUsers {
            self.onResult($0, completion: completion)
        }
        network.doRequest(request)
    }

    private func onResult(_ result: Result<[UserDTO], NetworkError>, completion: @escaping UserCallback) {
        switch result {
        case .success(let usersDTO):
            let users = usersDTO.compactMap { User($0) }
            completion(.success(users))
        case .failure(let error):
            completion(.failure(.other(error)))
        }
    }
}
