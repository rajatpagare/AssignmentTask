import Foundation
import CoreData

class UserStore {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func insert(_ user: User) {
        UserManagedObject.insert(user, with: context)
    }

    func fetchAll() -> [User] {
        return UserManagedObject.fetchAll(from: context)
    }
}
