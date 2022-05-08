import XCTest
@testable import HTTPClient

final class HTTPClientTests: XCTestCase {
    private var httpClient: HTTPClient!
    private var requester: MockHTTPRequester!
    
    override func setUpWithError() throws {
        let baseUrl = URL(string: "baseurl.com")!
        requester = MockHTTPRequester()
        httpClient = HTTPClient(baseURL: baseUrl, requester: requester)
    }
    
    func testGETSuccess() async throws {
        requester.shouldFail = false
        requester.statusCode = 200
        let result: Result<String, HTTPClientError> = await httpClient.get(path: "path", queryItems: [], headers: [:])
        XCTAssertEqual(try result.get(), "test")
    }
    
    func testGETSuccessWithBadStatusCode() async throws {
        requester.shouldFail = false
        requester.statusCode = 305
        let result: Result<String, HTTPClientError> = await httpClient.get(path: "path", queryItems: [], headers: [:])
        switch result {
        case .success:
            XCTFail("Expected failure")
        case .failure:
            break
        }
    }
    
    func testGETFailure() async {
        requester.shouldFail = true
        let result: Result<String, HTTPClientError> = await httpClient.get(path: "path", queryItems: [], headers: [:])
        switch result {
        case .success:
            XCTFail("Expected failure")
        case .failure:
            break
        }
    }
}

private final class MockHTTPRequester: HTTPRequester {
    var shouldFail = false
    var statusCode = 200
    
    func get(baseURL: URL, path: String, queryItems: [URLQueryItem], headers: [String : String]) async throws -> HTTPRequesterResponse {
        guard !shouldFail else {
            throw HTTPRequesterError.unknown
        }
        
        return (data: "\"test\"".data(using: .utf8)!, statusCode: statusCode)
    }
}
