import Quick
import Nimble
@testable import AssignmentTask

class NetworkRequestTests: QuickSpec {

    override func spec() {
        describe("building network requests") {
            describe("query items") {
                context("when there are none") {
                    it("url should not have any parameters") {
                        let request = MockNetworkRequest()
                        request.queryItems = nil

                        let baseURL = URL(string: "http://www.google.com")!
                        let built = try! request.buildURLRequest(withBaseURL: baseURL)
                        expect(built.url!.absoluteString).to(equal("http://www.google.com"))
                    }
                }
                context("when they are empty") {
                    it("url should not have any parameters") {
                        let request = MockNetworkRequest()
                        request.queryItems = []

                        let baseURL = URL(string: "http://www.google.com")!
                        let built = try! request.buildURLRequest(withBaseURL: baseURL)
                        expect(built.url!.absoluteString).to(equal("http://www.google.com"))
                    }
                }
                context("when there are query items but no path") {
                    it("url should have parameter for each key") {
                        let request = MockNetworkRequest()
                        request.queryItems = [
                            URLQueryItem(name: "a", value: "b"),
                            URLQueryItem(name: "x", value: "y")
                        ]

                        let baseURL = URL(string: "http://www.google.com")!
                        let built = try! request.buildURLRequest(withBaseURL: baseURL)
                        expect(built.url!.absoluteString).to(equal("http://www.google.com?a=b&x=y"))
                    }
                    it("url should have parameters for multiple matching keys") {
                        let request = MockNetworkRequest()
                        request.queryItems = [
                            URLQueryItem(name: "a", value: "b"),
                            URLQueryItem(name: "x", value: "y"),
                            URLQueryItem(name: "x", value: "foo")
                        ]

                        let baseURL = URL(string: "http://www.google.com")!
                        let built = try! request.buildURLRequest(withBaseURL: baseURL)
                        expect(built.url!.absoluteString).to(equal("http://www.google.com?a=b&x=y&x=foo"))
                    }

                }
                context("when there are query items that need encoding") {
                    it("encodes them") {
                        let request = MockNetworkRequest()
                        request.queryItems = [
                            URLQueryItem(name: "email", value: "matthew.hobbs@yahoo.co.uk"),
                            URLQueryItem(name: "phone", value: "+44 7861 293079")
                        ]
                        let baseURL = URL(string: "http://www.google.com")!
                        let built = try! request.buildURLRequest(withBaseURL: baseURL)
                        expect(built.url!.absoluteString).to(equal("http://www.google.com?email=matthew.hobbs@yahoo.co.uk&phone=%2B44%207861%20293079"))

                    }
                }
            }

        }
    }
}

private class MockNetworkRequest: NetworkRequest {

    var queryItems: [URLQueryItem]? = nil

    var path: String = ""

    var method: HTTPMethod = .get

    func handleResponse(_ response: NetworkResponse) throws { }

    func handleError(_ error: NetworkError) { }
}
