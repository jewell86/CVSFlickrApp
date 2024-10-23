import XCTest
@testable import CVSFlickrApp

final class ServiceTests: XCTestCase {
    var subject: Service!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        
        mockURLSession = MockURLSession()
        subject = Service(session: mockURLSession)
    }
    
    override func tearDown() {
        subject = nil
        mockURLSession = nil
        
        super.tearDown()
    }
    
    func test_searchImagesSuccess() async throws {
        // Given
        let response = mockImagesResponse()
        mockURLSession.data = response
        
        // When
        do {
            let images = try await subject.searchImages("porcupine")
            
            // Then
            XCTAssertEqual(images.count, 3)
            XCTAssertEqual(images[0].media.url, "https://live.staticflickr.com/65535/54077728957_d407c00486_m.jpg")
            XCTAssertEqual(images[1].media.url, "https://live.staticflickr.com/65535/54075652943_86d2b848a0_m.jpg")
            XCTAssertEqual(images[2].media.url, "https://live.staticflickr.com/65535/54074337490_a9f4377609_m.jpg")
        } catch {
            XCTFail("Test failed: \(error)")
        }
    }
    
    func test_searchImagesFailure() async throws {
        // Given
        let response = mockImagesResponseFailure()
        mockURLSession.data = response
        
        // When
        do {
            let _ = try await subject.searchImages("porcupine")
            XCTFail("Test failed")
        } catch {
            // Then
            XCTAssertNotNil(error)
        }
    }
}
