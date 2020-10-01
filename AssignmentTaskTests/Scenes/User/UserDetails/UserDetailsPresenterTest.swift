import Quick
import Nimble
@testable import AssignmentTask

class UserDetailsPresenterTest: QuickSpec {

    override func spec() {
        var display: MockUserDetailsDisplayLogic!
        var presenter: UserDetailsPresenter!

        beforeEach {
            display = MockUserDetailsDisplayLogic()
            presenter = UserDetailsPresenter()
            presenter.display = display
        }

        it("present user detail") {
            let user = MockedUser.userA
            presenter.presentUserDetails(response: .init(user: user))
            expect(display.displayUserDetailViewModel?.name.string).toEventually(equal("Name: Test A"))
            expect(display.displayUserDetailViewModel?.username.string).toEventually(equal("Username: test11"))
        }

        it("present favorite user") {
            presenter.presentFavoriteUpdate(response: .init(favorite: true))
            expect(display.displayFavoriteUserViewModel?.favorite).to(be(true))
        }
    }
}

private class MockUserDetailsDisplayLogic: UserDetailsDisplayLogic {

    var displayUserDetailViewModel: UserDetails.FetchDetails.ViewModel?
    var displayFavoriteUserViewModel: UserDetails.FavoriteUser.ViewModel?

    func displayUserDetail(viewModel: UserDetails.FetchDetails.ViewModel) {
        displayUserDetailViewModel = viewModel
    }

    func displayFavoriteUpdate(viewModel: UserDetails.FavoriteUser.ViewModel) {
        displayFavoriteUserViewModel = viewModel
    }
}
