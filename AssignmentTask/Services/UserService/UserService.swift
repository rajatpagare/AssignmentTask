import Foundation

protocol UserService {
    typealias UserCallback = (Result<[User], UserServiceError>) -> Void
    
    func getUsers(completion: @escaping UserCallback)
}

enum UserServiceError: Error {
    case other(Error)
}
