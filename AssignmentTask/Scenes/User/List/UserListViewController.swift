import UIKit

protocol UserListDisplayLogic: class {
    func displayUsers(viewModel: UserList.FetchUser.ViewModel)
    func displaySelectedUser(viewModel: UserList.FetchSelectedUser.ViewModel)
    func displayError(viewModel: UserList.Error.ViewModel)
}

class UserListViewController: UIViewController {

    var interactor: UserListBusinessLogic?
    var router: (NSObjectProtocol & UserListRoutingLogic & UserListDataPassing)?
    private var userDetails: [UserList.FetchUser.ViewModel.UserDetail] = []

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        UserListConfigurator().configure(self)
        interactor?.fetchUsers(request: .init())
        title = "Users"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension UserListViewController: UserListDisplayLogic {
    func displayUsers(viewModel: UserList.FetchUser.ViewModel) {
        userDetails = viewModel.userDetails
        tableView.reloadData()
    }

    func displaySelectedUser(viewModel: UserList.FetchSelectedUser.ViewModel) {
        router?.routeToDetails()
    }

    func displayError(viewModel: UserList.Error.ViewModel) {
        router?.routeToDisplayError(message: viewModel.message)
    }
}

extension UserListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UserListCell.self)
        let userDetail = userDetails[indexPath.row]
        cell.displayViewModel(userDetail)
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }

}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = userDetails[indexPath.row].identifier
        interactor?.fetchSelectedUser(request: .init(identifier: identifier))
    }
}

extension UserListViewController: UserListCellDelegate {

    func favoriteButtonTapped(indexpath: IndexPath) {
        let identifier = userDetails[indexpath.row].identifier
        interactor?.favoriteUser(request: .init(identifier: identifier))
    }
}
