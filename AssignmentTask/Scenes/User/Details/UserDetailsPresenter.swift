import UIKit

protocol UserDetailsPresentationLogic {
    func presentUserDetails(response: UserDetails.FetchDetails.Response)
    func presentFavoriteUpdate(response: UserDetails.FavoriteUser.Response)
}

class UserDetailsPresenter {
    weak var display: UserDetailsDisplayLogic?
}

extension UserDetailsPresenter: UserDetailsPresentationLogic {

    func presentUserDetails(response: UserDetails.FetchDetails.Response) {
        let name = NSAttributedString(string: "Name: \(response.user.name)")
            .withFont(.sfBold(14))
            .withTextColor(.darkGray)

        let username = NSAttributedString(string: "Username: \(response.user.username)")
            .withFont(.sfRegular(14))
            .withTextColor(.darkGray)

        let address = NSAttributedString(string: "Address: \(response.user.address.suite), \(response.user.address.street), \(response.user.address.city), \(response.user.address.zipcode)")
            .withFont(.sfRegular(14))
            .withTextColor(.darkGray)

        let company = NSAttributedString(string: "Company: \(response.user.company.name)")
            .withFont(.sfRegular(14))
            .withTextColor(.darkGray)

        let contact = NSAttributedString(string: "Contact: \(response.user.phone), \(response.user.website)")
            .withFont(.sfRegular(14))
            .withTextColor(.darkGray)
        
        display?.displayUserDetail(viewModel: .init(name: name, username: username, address: address, company: company, contactDetail: contact, favorite: response.user.favorite))

    }

    func presentFavoriteUpdate(response: UserDetails.FavoriteUser.Response) {
        display?.displayFavoriteUpdate(viewModel: .init(favorite: response.favorite))
    }
}
