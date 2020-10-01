import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()

    private var services: [String: Any] = [:]
    func registerService<T>(_ service: T, forKey key: String) {
        services[key] = service
    }

    func service<T>(forKey key: String) -> T {
        // swiftlint:disable force_cast
        return services[key] as! T
        // swiftlint:enable force_cast
    }

    func service<T>(forKey key: String, orCreate creator: @autoclosure () -> T) -> T {
        guard let value = services[key] as? T else {
            let created = creator()
            services[key] = created
            return created
        }
        return value
    }
}
