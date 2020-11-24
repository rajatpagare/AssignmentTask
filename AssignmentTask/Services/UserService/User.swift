import Foundation

struct User {

    let id: Int
    let name: String
    let username: String
    let email: String
    let address: UserAddress
    let phone: String
    let website: String
    let company: UserCompany
    var favorite: Bool

    struct UserAddress {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: UserAddressCoordinates

        struct UserAddressCoordinates {
            let lat: String
            let lng: String
        }
    }

    struct UserCompany {
        let name: String
        let catchPhrase: String
        let bs: String
    }

    mutating func updateFavorite(_ isFavorite: Bool) {
        favorite = isFavorite
    }
}

extension User {
    init(_ from: UserDTO) {
        id = from.id
        name = from.name
        username = from.username
        email = from.email
        address = UserAddress(from.address)
        phone = from.phone
        website = from.website
        company = UserCompany(from.company)
        favorite = false
    }
}

private extension User.UserAddress {
    init(_ from: UserDTO.UserAddressDTO) {
        street = from.street
        suite = from.suite
        city = from.city
        zipcode = from.zipcode
        geo = UserAddressCoordinates(from.geo)
    }
}

private extension User.UserAddress.UserAddressCoordinates {
    init(_ from: UserDTO.UserAddressDTO.UserAddressCoordinatesDTO) {
        lat = from.lat
        lng = from.lng
    }
}

private extension User.UserCompany {
    init(_ from: UserDTO.UserCompanyDTO) {
        name = from.name
        catchPhrase = from.catchPhrase
        bs = from.bs
    }
}
