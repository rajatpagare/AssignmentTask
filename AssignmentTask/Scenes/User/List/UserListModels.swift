import UIKit

enum UserList {

    enum FetchUser {
        struct Request { }
        struct Response {
            let users: [User]
        }
        struct ViewModel {
            let userDetails: [UserDetail]
            struct UserDetail {
                typealias Identifier = Int
                let isFavorite: Bool
                let identifier: Identifier
                let name: NSAttributedString
                let phoneNumber: NSAttributedString
                let website: NSAttributedString
                let company: NSAttributedString
            }
        }
    }

    enum Error {
        struct Request { }
        struct Response {
            let message: String
        }
        struct ViewModel {
            let message: String
        }
    }

    enum FetchSelectedUser {
        struct Request {
            typealias Identifier = Int
            let identifier: Identifier
        }
        struct Response { }
        struct ViewModel { }
    }

    enum FavoriteUser {
        struct Request {
            typealias Identifier = Int
            let identifier: Identifier
        }
    }
}
