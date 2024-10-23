import XCTest

class ImageGridViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func test_initialLoad() {
        let searchBar = app.searchFields["Search for images"]
        XCTAssertTrue(searchBar.exists)
        
        let noImagesText = app.staticTexts["No images to display :("]
        XCTAssertTrue(noImagesText.exists)
    }
    
    func test_searchFunctionality() {
        let searchBar = app.searchFields["Search for images"]
        XCTAssertTrue(searchBar.exists)
        
        searchBar.tap()
        searchBar.typeText("Puppy")
        
        let firstImage = app.images.element(boundBy: 2)
        XCTAssertTrue(firstImage.waitForExistence(timeout: 1))
    }
}
