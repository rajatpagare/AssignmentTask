import UIKit

protocol UserDetailsDisplayLogic: class {
    func displayUserDetail(viewModel: UserDetails.FetchDetails.ViewModel)
    func displayFavoriteUpdate(viewModel: UserDetails.FavoriteUser.ViewModel)
}

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var phoneAndWebsiteLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var interactor: UserDetailsBusinessLogic?
    var router: (NSObjectProtocol & UserDetailsRoutingLogic & UserDetailsDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        interactor?.fetchUserDetails(request: .init())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        interactor?.favoriteUser(request: .init())
    }
}

extension UserDetailsViewController: UserDetailsDisplayLogic {
    func displayUserDetail(viewModel: UserDetails.FetchDetails.ViewModel) {
        nameLabel.attributedText = viewModel.name
        usernameLabel.attributedText = viewModel.username
        addressLabel.attributedText = viewModel.address
        companyLabel.attributedText = viewModel.company
        phoneAndWebsiteLabel.attributedText = viewModel.contactDetail
        favoriteButton.isSelected = viewModel.favorite
    }

    func displayFavoriteUpdate(viewModel: UserDetails.FavoriteUser.ViewModel) {
        favoriteButton.isSelected = viewModel.favorite
    }
}

extension UserDetailsViewController: ProvidesControllerInstantiator {
    static var instantiator: ControllerInstantiator = DefaultControllerInstantiator.storyboard(DefaultControllerNamingStrategy.namedAfterWithoutViewControllerSuffix(UserDetailsViewController.self))
}
