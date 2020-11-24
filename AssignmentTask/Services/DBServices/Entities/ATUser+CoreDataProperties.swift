import UIKit
import CoreData

extension ATUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ATUser> {
        return NSFetchRequest<ATUser>(entityName: "ATUser")
    }

    @NSManaged public var email: String
    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var username: String
    @NSManaged public var website: String
    @NSManaged public var userToAddress: Address
    @NSManaged public var userToCompany: Company

    var user: User {
        get {
            return User(id: Int(id),
                        name: name,
                        username: username,
                        email: email,
                        address: User.UserAddress(street: userToAddress.street,
                                                  suite: userToAddress.suite,
                                                  city: userToAddress.city,
                                                  zipcode: userToAddress.zipcode,
                                                  geo: User.UserAddress.UserAddressCoordinates(lat: userToAddress.addressToCoordinates.lat,
                                                                                               lng: userToAddress.addressToCoordinates.long)),
                        phone: phone,
                        website: website,
                        company: User.UserCompany(name: userToCompany.name,
                                                  catchPhrase: userToCompany.catchPhrase,
                                                  bs: userToCompany.bs),
                        favorite: false)
        }
        set {
            email = newValue.email
            id = Int64(newValue.id)
            name = newValue.name
            phone = newValue.phone
            username = newValue.username
            website = newValue.website
        }
    }

}
