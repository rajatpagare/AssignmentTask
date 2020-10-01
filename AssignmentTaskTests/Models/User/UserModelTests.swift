import XCTest
import Quick
import Nimble
@testable import AssignmentTask

class UserModelTests: QuickSpec {
    override func spec() {
        var user = User(fromFile: "UserTest.json")

        it("test data type are valid") {
            expect(user.id).to(equal(10))
            expect(user.name).to(equal("Clementina DuBuque"))
            expect(user.username).to(equal("Moriah.Stanton"))
            expect(user.email).to(equal("Rey.Padberg@karina.biz"))
            expect(user.address.suite).to(equal("Suite 198"))
            expect(user.address.street).to(equal("Kattie Turnpike"))
            expect(user.address.city).to(equal("Lebsackbury"))
            expect(user.address.zipcode).to(equal("31428-2261"))
            expect(user.address.geo.lat).to(equal("-38.2386"))
            expect(user.address.geo.lng).to(equal("57.2232"))
            expect(user.phone).to(equal("024-648-3804"))
            expect(user.website).to(equal("ambrose.net"))
            expect(user.company.name).to(equal("Hoeger LLC"))
            expect(user.company.bs).to(equal("target end-to-end models"))
            expect(user.company.catchPhrase).to(equal("Centralized empowering task-force"))
            expect(user.favorite).to(equal(false))
        }

        it("test updating favorite user") {
            user.updateFavorite(true)
            expect(user.favorite).to(equal(true))
        }
    }
}
