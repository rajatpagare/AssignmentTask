import UIKit

enum UserDetails {

    enum FetchDetails {
        struct Request { }
        struct Response {
            let user: User
        }
        struct ViewModel {
            let name: NSAttributedString
            let username: NSAttributedString
            let address: NSAttributedString
            let company: NSAttributedString
            let contactDetail: NSAttributedString
            let favorite: Bool
        }
    }

    enum FavoriteUser {
        struct Request { }
        struct Response {
            let favorite: Bool
        }
        struct ViewModel {
            let favorite: Bool
        }
    }
}
