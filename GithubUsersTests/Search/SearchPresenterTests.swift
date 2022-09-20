//
//  SearchPresenterTests.swift
//  GithubUsersTests
//
//  Created by Anang Nugraha on 19/09/22.
//

import XCTest
@testable import GithubUsers

class SearchPresenterTests: XCTestCase {

    var presenter: SearchPresenter?
    var mockWireframe: MockWireframe!
    var mockInteractor: MockInteractor!
    
    override func setUpWithError() throws {
         try super.setUpWithError()
        mockWireframe = MockWireframe()
        mockInteractor = MockInteractor()
        presenter = SearchPresenter(interactor: mockInteractor, wireframe: mockWireframe)
    }

    override func tearDownWithError() throws {
        mockWireframe = nil
        mockInteractor = nil
        presenter = nil
        try? super.tearDownWithError()
    }
    
    func testResetData() {
        presenter?.totalPage = 666
        presenter?.currentPage = 666
        presenter?.resetData()
        XCTAssertEqual(presenter?.allUsers?.count, 0)
        XCTAssertEqual(presenter?.totalPage, 1)
        XCTAssertEqual(presenter?.currentPage, 1)
    }
    
    func testSaveFavoriteUser() {
        var mockData = mockUserModel()
        mockData.username = "mockUser"
        presenter?.saveFavoriteUser(with: mockData)
        XCTAssertEqual(mockInteractor.addUserToFavoriteUserName, mockData.username)
    }
    
    func testFetchSearchUsers() {
        presenter?.searchQuery = "mockUser"
        presenter?.fetchSearchUsers()
        XCTAssertEqual(mockWireframe.isSetLoadingIndicatorCalled, true)
        XCTAssertEqual(mockWireframe.isLoadingHiddenState, false)
        XCTAssertEqual(mockInteractor.getAllSearchUsersQuery, presenter?.searchQuery)
    }
    
    func testAddUserToFavoriteResult_withStateTrue() {
        let mockState = true
        presenter?.addUserToFavoriteResult(isSuccess: mockState)
        XCTAssertEqual(mockWireframe.isShowFavoriteAlertCalled, true)
        XCTAssertEqual(mockWireframe.showFavoriteAlertState, mockState)
    }
    
    func testAddUserToFavoriteResult_withStateFalse() {
        let mockState = false
        presenter?.addUserToFavoriteResult(isSuccess: mockState)
        XCTAssertEqual(mockWireframe.isShowFavoriteAlertCalled, true)
        XCTAssertEqual(mockWireframe.showFavoriteAlertState, mockState)
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
    
    func testGetAllSearchUserDidSuccess() {
        var mockData = mockGitUserModel()
        mockData.totalCount = 30
        presenter?.getAllSearchUserDidSuccess(mockData)
        XCTAssertEqual(presenter?.allUsers?.count, mockData.items?.count)
        XCTAssertEqual(presenter?.totalPage, 2)
        XCTAssertEqual(presenter?.firstCalled, false)
        XCTAssertEqual(presenter?.isLoadData, false)
        
        let expectation = expectation(description: "getAllSearchUserDidSuccess")
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockWireframe.isLoadingHiddenState)
            XCTAssertTrue(self.mockWireframe.isSetLoadingIndicatorCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetAllSearchUserDidSuccess_withItemsNil() {
        var mockData = mockGitUserModel()
        mockData.totalCount = 30
        mockData.items = nil
        presenter?.getAllSearchUserDidSuccess(mockData)
        XCTAssertEqual(presenter?.allUsers?.count, 0)
        XCTAssertEqual(presenter?.totalPage, 2)
        XCTAssertEqual(presenter?.firstCalled, false)
        XCTAssertEqual(presenter?.isLoadData, false)
        
        let expectation = expectation(description: "getAllSearchUserDidSuccess")
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockWireframe.isLoadingHiddenState)
            XCTAssertTrue(self.mockWireframe.isSetLoadingIndicatorCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

extension SearchPresenterTests {
    class MockWireframe: SearchWireframeProtocol {
        
        var isErrorAlertCalled = false
        var showErrorAlertMessage = ""
        var isSetLoadingIndicatorCalled = false
        var isLoadingHiddenState = false
        var isShowNoInternetAlertCalled = false
        var isShowFavoriteAlertCalled = false
        var showFavoriteAlertState = false
        
        func showFavoriteAlert(isSuccess: Bool) {
            isShowFavoriteAlertCalled = true
            showFavoriteAlertState = isSuccess
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
    
    class MockInteractor: SearchInteractorProtocol {
        var addUserToFavoriteUserName = ""
        var getAllSearchUsersQuery = ""
        func addUserToFavorite(user: UserModel) {
            addUserToFavoriteUserName = user.username ?? ""
        }
        
        func getAllSearchUsers(request: SearchUserRequest) {
            getAllSearchUsersQuery = request.query
        }
    }
}

extension SearchPresenterTests {
    func mockUserModel() -> UserModel {
        let decoder = JSONDecoder()
        
        guard
            let pathString = Bundle.main.url(forResource: "UserModel", withExtension: "json"),
            let dataJson = try? Data(contentsOf: pathString, options: .mappedIfSafe),
            let model = try? decoder.decode(UserModel.self, from: dataJson)
        else {
            fatalError()
        }
                
        return model
    }
    
    func mockGitUserModel() -> GitUserModel {
        let decoder = JSONDecoder()
        
        guard
            let pathString = Bundle.main.url(forResource: "GitUserModel", withExtension: "json"),
            let dataJson = try? Data(contentsOf: pathString, options: .mappedIfSafe),
            let model = try? decoder.decode(GitUserModel.self, from: dataJson)
        else {
            fatalError()
        }
                
        return model
    }
}
