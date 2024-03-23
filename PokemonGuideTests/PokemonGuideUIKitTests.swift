//
//  PokemonGuideUIKitTests.swift
//  PokemonGuideTests
//
//  Created by   on 15.03.2024.
//

import XCTest
import Combine
@testable import PokemonGuide

final class PokemonGuideUIKitTests: XCTestCase {
    var viewModel: ListTableViewModel!
    var mockHttpTask: MockHTTPTask!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        mockHttpTask = MockHTTPTask()
        viewModel = ListTableViewModel(httpTask: mockHttpTask)
    }
    
    override func tearDown() {
        viewModel = nil
        mockHttpTask = nil
        super.tearDown()
    }
    
    func testFetchPokemonItems_Success() async throws {
        let expectedItems = [PokemonItem(id: 1, name: "Pikachu", description: "", imageUrl: "")]
        mockHttpTask.itemsToReturn = expectedItems
        
        viewModel.fetchPokemonItems()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { items in
                XCTAssertEqual(items, expectedItems)
            }
            .store(in: &cancellables)
    }
    
    func testFetchPokemonItems_Failure() async throws {
        mockHttpTask.shouldThrowError = true
        
        viewModel.fetchPokemonItems()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { items in
                XCTAssertTrue(items.isEmpty)
            }
            .store(in: &cancellables)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
