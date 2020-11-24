import Foundation
import CoreData

extension AddressCoordinates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressCoordinates> {
        return NSFetchRequest<AddressCoordinates>(entityName: "AddressCoordinates")
    }

    @NSManaged public var lat: String
    @NSManaged public var long: String

    var coordinates: User.UserAddress.UserAddressCoordinates {
        get {
            return User.UserAddress.UserAddressCoordinates(lat: lat, lng: long)
        }
        set {
            lat = newValue.lat
            long = newValue.lng
        }
    }
}
