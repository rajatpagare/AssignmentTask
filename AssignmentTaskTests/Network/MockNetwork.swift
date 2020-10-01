import Foundation
@testable import AssignmentTask

class MockNetwork: Network {

    let response: MockNetworkResponse
    var request: NetworkRequest!

    init(_ response: MockNetworkResponse) {
        self.response = response
    }

    func doRequest(_ request: NetworkRequest) {
        self.request = request
        switch response {
        case .ok(let method, let path, let response) where method == request.method && path == request.path:
            try! request.handleResponse(response)
        case .failure(let error):
            request.handleError(error)
        default:
            request.handleError(.unknownError)
        }
    }
    
}
