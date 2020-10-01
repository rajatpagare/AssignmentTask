import Foundation

enum UserAPI: NetworkRequest {
    
    typealias UserCallback = (Result<[UserDTO], NetworkError>) -> Void
    case getUsers(callback: UserCallback)

    var path: String {
        switch self {
        case .getUsers: return "/users"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUsers: return .get
        }
    }

    func handleResponse(_ response: NetworkResponse) throws {
        switch (self, response) {
        case (.getUsers(let callback), .data(let data)):
            do {
                let decoder = JSONDecoder()
                let dto = try decoder.decode([UserDTO].self, from: data)
                callback(.success(dto))
            } catch {
                print(error.localizedDescription)
            }
        default:
            throw NetworkError.invalidResponse
        }
    }

    func handleError(_ error: NetworkError) {
        switch self {
        case .getUsers(let callback):
            callback(.failure(error))
        }
    }

    var contentType: ContentType {
        switch self {
        case .getUsers:
            return .json
        }
    }
}
