import XCTest
@testable import CVSFlickrApp

class ViewModelTests: XCTestCase {
    var subject: ViewModel!
    var mockService: MockService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockService = MockService()
        subject = ViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        subject = nil
        mockService = nil
        
        try super.tearDownWithError()
    }

    func test_searchImages() async throws {
        // Given
        mockService.images = [ImageInfo.testMake()]
        let asyncTimeout = XCTestExpectation(description: "timeout")

        // When
        await subject.receive(event: .searchImages("dog, cat"))
        asyncTimeout.fulfill()
        
        // Then
        await fulfillment(of: [asyncTimeout], timeout: 1)
        XCTAssertEqual(subject.images.count, 1)
        XCTAssertEqual(subject.images.first?.media.url, "https://tinyurl.com/5pntcptk")
    }
}
