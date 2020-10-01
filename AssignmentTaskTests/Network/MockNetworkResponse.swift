import Foundation
@testable import AssignmentTask

enum MockNetworkResponse {
    case ok(HTTPMethod, String, NetworkResponse)
    case failure(NetworkError)
}

extension NetworkResponse {

    static func fromString(_ value: String) -> NetworkResponse {
        let data = value.data(using: .utf8)!
        return .data(data)
    }

}
