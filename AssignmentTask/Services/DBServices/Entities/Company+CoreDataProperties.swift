import Foundation
import CoreData

extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String
    @NSManaged public var bs: String
    @NSManaged public var catchPhrase: String

    var company: User.UserCompany {
        get {
            return User.UserCompany(name: name, catchPhrase: catchPhrase, bs: bs)
        }
        set {
            name = newValue.name
            bs = newValue.bs
            catchPhrase = newValue.catchPhrase
        }
    }
}
