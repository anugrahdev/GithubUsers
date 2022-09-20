//
//  FavoritesPresenterTests.swift
//  GithubUsersTests
//
//  Created by Anang Nugraha on 20/09/22.
//

import XCTest
@testable import GithubUsers

class FavoritesPresenterTests: XCTestCase {

    var presenter: FavoritesPresenter?
    var mockWireframe: MockWireframe!
    var mockInteractor: MockInteractor!
    var mockView: MockView!
    
    override func setUpWithError() throws {
         try super.setUpWithError()
        mockWireframe = MockWireframe()
        mockInteractor = MockInteractor()
        mockView = MockView()
        presenter = FavoritesPresenter(interactor: mockInteractor, wireframe: mockWireframe)
        presenter?.view = mockView
    }

    override func tearDownWithError() throws {
        mockWireframe = nil
        mockInteractor = nil
        presenter = nil
        mockView = nil
        try? super.tearDownWithError()
    }
    
    func testResetData() {
        presenter?.resetData()
        XCTAssertEqual(presenter?.allUsers?.count, 0)
    }

    func testFetchAllFavoriteUsers() {
        presenter?.fetchAllFavoriteUsers()
        XCTAssertEqual(mockInteractor.getAllFavoriteUsersCalled, true)
    }
    
    func testRemoveUserFromFavorite() {
        let mockUsername = "mockUser"
        let mockData = StubUser(username: mockUsername)
        presenter?.removeUserFromFavorite(user: mockData)
        XCTAssertEqual(mockInteractor.removeUserFromFavoriteCalled, true)
        XCTAssertEqual(mockInteractor.removeUserFromFavoriteUsername, mockUsername)
    }
    
    func testRemoveUserFromFavoriteDidSuccess() {
        presenter?.removeUserFromFavoriteDidSuccess()
        XCTAssertEqual(mockWireframe.isShowFavoriteAlertCalled, true)
    }
    
    func testServiceRequestDidFail() {
        let error = NSError(domain: "", code: 401, userInfo: ["error": "request error"])
        presenter?.serviceRequestDidFail(error)
        
        let expectation = expectation(description: "serviceRequestDidFail")
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockWireframe.isLoadingHiddenState)
            XCTAssertTrue(self.mockWireframe.isSetLoadingIndicatorCalled)
            XCTAssertTrue(self.mockWireframe.isErrorAlertCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetAllFavoriteUsersDidSuccess() {
        let mockUsername = "mockUser"
        let mockData = StubUser(username: mockUsername)
        let mockList = [mockData, mockData]
        presenter?.getAllFavoriteUsersDidSuccess(mockList)
        XCTAssertEqual(presenter?.allUsers?.count, mockList.count)
        
        let expectation = expectation(description: "getAllFavoriteUsersDidSuccess")
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockView.getReloadDataCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
}

extension FavoritesPresenterTests {
    
    class MockWireframe: FavoritesWireframeProtocol {

        var isErrorAlertCalled = false
        var showErrorAlertMessage = ""
        var isSetLoadingIndicatorCalled = false
        var isLoadingHiddenState = false
        var isShowNoInternetAlertCalled = false
        var isShowFavoriteAlertCalled = false
        var showFavoriteAlertState = false

        func showFavoriteAlert() {
            isShowFavoriteAlertCalled = true
        }
        
        func setLoadingIndicator(isHidden: Bool) {
            isLoadingHiddenState = isHidden
            isSetLoadingIndicatorCalled = true
        }
        
        func showNoInternetAlert() {
            isShowNoInternetAlertCalled = true
        }
        
        func showErrorAlert(_ message: String) {
            isErrorAlertCalled = true
            showErrorAlertMessage = message
        }
    }
    
    class MockInteractor: FavoritesInteractorProtocol {
        
        var getAllFavoriteUsersCalled = false
        var removeUserFromFavoriteCalled = false
        var removeUserFromFavoriteUsername = ""
        
        func getAllFavoriteUsers() {
            getAllFavoriteUsersCalled = true
        }
        
        func removeUserFromFavorite(user: FavoriteUser) {
            removeUserFromFavoriteCalled = true
            removeUserFromFavoriteUsername = user.username ?? ""
        }
    }
    
    class MockView: FavoritesViewProtocol {
        var getReloadDataCalled = false

        func reloadData() {
            getReloadDataCalled = true
        }
    }
    
}

extension FavoritesPresenterTests {
    class StubUser: FavoriteUser {
        convenience init(username: String = "") {
            self.init()
            self.stubbedName = username
        }

        var stubbedName: String = ""
        override var username: String? {
            set {}
            get {
                return stubbedName
            }
        }
    }

}
