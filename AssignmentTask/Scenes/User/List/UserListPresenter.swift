import UIKit

protocol UserListPresentationLogic {
    func presentUsers(response: UserList.FetchUser.Response)
    func presentError(response: UserList.Error.Response)
    func presentSelectedUser(response: UserList.FetchSelectedUser.Response)
}

class UserListPresenter {
    weak var display: UserListDisplayLogic?
}

extension UserListPresenter: UserListPresentationLogic {

    func presentUsers(response: UserList.FetchUser.Response) {
        let userDetails: [UserList.FetchUser.ViewModel.UserDetail] = response.users.map { user in
            let name = NSAttributedString(string: "Name: \(user.name)")
                .withFont(.sfBold(14))
                .withTextColor(.darkGray)

            let phoneNumber = NSAttributedString(string: "Contact Number: \(user.phone)")
                .withFont(.sfRegular(14))
                .withTextColor(.darkGray)

            let website = NSAttributedString(string: "Website: \(user.website)")
                .withFont(.sfRegular(14))
                .withTextColor(.darkGray)

            let company = NSAttributedString(string: "Company: \(user.company.name)")
                .withFont(.sfSemibold(14))
                .withTextColor(.darkGray)

            return UserList.FetchUser.ViewModel.UserDetail(isFavorite: user.favorite, identifier: user.id, name: name, phoneNumber: phoneNumber, website: website, company: company)
        }
        DispatchQueue.main.async {
            self.display?.displayUsers(viewModel: .init(userDetails: userDetails))
        }
    }

    func presentError(response: UserList.Error.Response) {
        display?.displayError(viewModel: .init(message: response.message))
    }

    func presentSelectedUser(response: UserList.FetchSelectedUser.Response) {
        display?.displaySelectedUser(viewModel: .init())
    }
}
