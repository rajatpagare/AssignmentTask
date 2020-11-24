import Foundation
import CoreData

extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String
    @NSManaged public var street: String
    @NSManaged public var suite: String
    @NSManaged public var zipcode: String
    @NSManaged public var addressToCoordinates: AddressCoordinates

    var address: User.UserAddress {
        get {
            return User.UserAddress(street: street, suite: suite, city: city, zipcode: zipcode, geo: User.UserAddress.UserAddressCoordinates(lat: addressToCoordinates.lat, lng: addressToCoordinates.long))
        }
        set {
            city = newValue.city
            street = newValue.street
            suite = newValue.suite
            zipcode = newValue.zipcode
        }
    }
}
