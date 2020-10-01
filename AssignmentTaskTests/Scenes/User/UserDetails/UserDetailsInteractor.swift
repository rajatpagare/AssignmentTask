import XCTest
import Quick
import Nimble
@testable import AssignmentTask

class UserDetailsInteractorTest: QuickSpec {

    override func spec() {
        var interactor: UserDetailsInteractor!
        var presenter: MockUserDetailsPresenter!

        beforeEach {
            interactor = UserDetailsInteractor()
            presenter = MockUserDetailsPresenter()
            interactor.presenter = presenter
        }

        it("fetch user details") {
            interactor.selectedUser = MockedUser.userA
            interactor.fetchUserDetails(request: .init())
            expect(presenter.presetUserDetailsResponse?.user.name).toEventually(be("Test A"))
            expect(presenter.presetUserDetailsResponse?.user.username).toEventually(be("test11"))
        }

        it("make favorite user") {
            interactor.selectedUser = User(fromFile: "UserTest.json")
            expect(interactor.selectedUser?.favorite).toEventually(be(false))
            interactor.favoriteUser(request: .init())
            expect(presenter.presentFavoriteResponse?.favorite).toEventually(be(true))
        }
    }
}

class MockUserDetailsPresenter: UserDetailsPresentationLogic {

    var presetUserDetailsResponse: UserDetails.FetchDetails.Response?
    var presentFavoriteResponse: UserDetails.FavoriteUser.Response?

    func presentUserDetails(response: UserDetails.FetchDetails.Response) {
        presetUserDetailsResponse = response
    }

    func presentFavoriteUpdate(response: UserDetails.FavoriteUser.Response) {
        presentFavoriteResponse = response
    }
}
