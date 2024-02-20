//
//  NYTimesSplashViewControllerTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesSplashViewControllerTests: XCTestCase {
    var sut: NYTimesSplashViewController!
    var presenter: NYTimesSplashPresenterMock!
    
    override func setUpWithError() throws {
        presenter = NYTimesSplashPresenterMock()
        sut = NYTimesSplashViewController(presenter: presenter)
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        sut = nil
    }
    
    func testInitComponents() {
        sut.initComponents()
        XCTAssertEqual(sut.view.backgroundColor, .nyTimesWhite)
    }
    
    func testViewWillAppear() {
        let expect = expectation(description: "Test view will appear")
        presenter.expectRequestArticles = expect
        sut.viewWillAppear(true)
        wait(for: [expect], timeout: 1)
    }
    
    func testNotifyError() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: sut)
        appDelegate.window?.rootViewController = navigation
        appDelegate.window?.makeKeyAndVisible()

        let expectation = self.expectation(description: "Expect wait")
        
        sut.notifyError(data: .getDefaultError(type: .unknown), localArticlesExists: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1.5)
        XCTAssertTrue(self.sut.navigationController?.visibleViewController is UIAlertController)
    }
}
