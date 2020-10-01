import Foundation
import Quick
import Nimble
@testable import AssignmentTask

struct MockedUser {
    static let userA = User(id: 1,
                             name: "Test A",
                             username: "test11",
                             email: "test@test.com",
                             address: User.UserAddress(street: "401",
                                                       suite: "A-3",
                                                       city: "Indore",
                                                       zipcode: "452001",
                                                       geo: User.UserAddress.UserAddressCoordinates(lat: "22.7196",
                                                                                                    lng: "75.8577")),
                             phone: "xxx-xxxx-xxx",
                             website: "xyz.com",
                             company: User.UserCompany(name: "XYZ",
                                                       catchPhrase: "123",
                                                       bs: "123"),
                             favorite: false)

    static let userB = User(id: 2,
                             name: "Test B",
                             username: "test123",
                             email: "test@test.com",
                             address: User.UserAddress(street: "401",
                                                       suite: "A-3",
                                                       city: "Indore",
                                                       zipcode: "452001",
                                                       geo: User.UserAddress.UserAddressCoordinates(lat: "22.7196",
                                                                                                    lng: "75.8577")),
                             phone: "xxx-xxxx-xxx",
                             website: "xyz.com",
                             company: User.UserCompany(name: "XYZ",
                                                       catchPhrase: "123",
                                                       bs: "123"),
                             favorite: false)
}
