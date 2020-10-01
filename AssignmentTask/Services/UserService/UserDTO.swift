import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: UserAddressDTO
    let phone: String
    let website: String
    let company: UserCompanyDTO

    struct UserAddressDTO: Decodable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: UserAddressCoordinatesDTO

        struct UserAddressCoordinatesDTO: Decodable {
            let lat: String
            let lng: String
        }
    }

    struct UserCompanyDTO: Decodable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}


