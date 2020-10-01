import Foundation
@testable import AssignmentTask

extension User {

    private class Loader: NSObject { }

    init(fromFile name: String) {
        let dto: UserDTO = Loader.loadFromJSONFile(name)
        self.init(dto)
    }
}

extension NSObject {

    static func loadFromJSONFile<T>(_ name: String) -> T where T: Decodable {
        let bundle = Bundle(for: self)
        let parts = name.components(separatedBy: ".")
        let url = bundle.url(forResource: parts[0], withExtension: parts[1])!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(T.self, from: data)
    }

}
