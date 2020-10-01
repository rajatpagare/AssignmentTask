import Foundation
import Quick
import Nimble
@testable import AssignmentTask

class FavoriteUserDataStoreTest: QuickSpec {
    override func spec() {
        var store: FavoriteUserDataStore!
        beforeEach {
            let suiteName = String(describing: self)
            let userDefaults = UserDefaults(suiteName: suiteName)!
            store = FavoriteUserDataStore(userDefaults: userDefaults)
            userDefaults.removePersistentDomain(forName: suiteName)
            userDefaults.synchronize()
        }
        it("get favorite users initially") {
            expect(store.getFavoriteUserIdentifiers()).to(haveCount(0))
        }

        it("set favorite user") {
            store.setFavoriteUser(identifier: 1)
            expect(store.getFavoriteUserIdentifiers()).to(haveCount(1))

            store.setFavoriteUser(identifier: 1)
            expect(store.getFavoriteUserIdentifiers()).to(haveCount(1))

            store.setFavoriteUser(identifier: 2)
            expect(store.getFavoriteUserIdentifiers()).to(haveCount(2))
        }

        it("remove favorite user") {
            store.removeFavoriteUser(identifier: 1)
            expect(store.getFavoriteUserIdentifiers()).to(haveCount(0))

            store.setFavoriteUser(identifier: 1)
            expect(store.getFavoriteUserIdentifiers()).to(haveCount(1))

            store.removeFavoriteUser(identifier: 1)
            expect(store.getFavoriteUserIdentifiers()).to(haveCount(0))
        }
    }
}
