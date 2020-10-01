import Quick
import Nimble
@testable import AssignmentTask

class UserListPresenterTest: QuickSpec {

    override func spec() {
        var display: MockUserListDisplayLogic!
        var presenter: UserListPresenter!

        beforeEach {
            display = MockUserListDisplayLogic()
            presenter = UserListPresenter()
            presenter.display = display
        }

        it("present users") {
            presenter.presentUsers(response: .init(users: [MockedUser.userA, MockedUser.userB]))
            expect(display.displayUsersViewModel?.userDetails).toEventually(haveCount(2))
        }

        it("present selected user") {
            presenter.presentSelectedUser(response: .init())
            expect(display.displaySelectedUserViewModel).to(beNil())
        }

        it("present error message") {
            presenter.presentError(response: .init(message: "Error aa gya :("))
            expect(display.displayErrorViewModel?.message).to(equal("Error aa gya :("))
        }
    }
}

private class MockUserListDisplayLogic: UserListDisplayLogic {

    var displayUsersViewModel: UserList.FetchUser.ViewModel?
    var displaySelectedUserViewModel: UserList.FetchSelectedUser.ViewModel?
    var displayErrorViewModel: UserList.Error.ViewModel?

    func displayUsers(viewModel: UserList.FetchUser.ViewModel) {
        displayUsersViewModel = viewModel
    }

    func displaySelectedUser(viewModel: UserList.FetchSelectedUser.ViewModel) {
        displaySelectedUserViewModel = nil
    }

    func displayError(viewModel: UserList.Error.ViewModel) {
        displayErrorViewModel = viewModel
    }
}
