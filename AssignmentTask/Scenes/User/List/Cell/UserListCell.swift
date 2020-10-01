import UIKit

protocol UserListCellDelegate: NSObjectProtocol {
    func favoriteButtonTapped(indexpath: IndexPath)
}

class UserListCell: UITableViewCell, Reusable {

    typealias ViewModel = UserList.FetchUser.ViewModel.UserDetail

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    weak var delegate: UserListCellDelegate?
    var indexPath: IndexPath?

    func displayViewModel(_ viewModel: ViewModel) {
        nameLabel.attributedText = viewModel.name
        phoneNumberLabel.attributedText = viewModel.phoneNumber
        websiteLabel.attributedText = viewModel.website
        companyLabel.attributedText = viewModel.company
        favoriteButton.isSelected = viewModel.isFavorite
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let indexpath = indexPath else { return }
        delegate?.favoriteButtonTapped(indexpath: indexpath)
    }

}
