import Foundation
import CoreData

protocol UserObjectConvertible {
    static func insert(_ user: User, with context: NSManagedObjectContext)
    static func fetchAll(from context: NSManagedObjectContext) -> [User]
}

extension UserObjectConvertible {

    static func insert(_ user: User, with context: NSManagedObjectContext) {
        let atUser = ATUser(context: context)
        atUser.user = user

        let address = Address(context: context)
        address.address = user.address
        atUser.userToAddress = address

        let coordinates = AddressCoordinates(context: context)
        coordinates.coordinates = user.address.geo
        atUser.userToAddress.addressToCoordinates = coordinates

        let company = Company(context: context)
        company.company = user.company
        atUser.userToCompany = company

        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }

    static func fetchAll(from context: NSManagedObjectContext) -> [User] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ATUser")
        request.returnsObjectsAsFaults = false

        do {
            guard let managedObjects = try context.fetch(request) as? [ATUser] else { return [] }
            return managedObjects.compactMap { $0.user }
        } catch {
            return []
        }
    }
}
