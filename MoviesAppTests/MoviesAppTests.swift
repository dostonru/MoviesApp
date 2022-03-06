//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Doston Rustamov on 05/03/22.
//

import XCTest
@testable import MoviesApp

class MoviesAppTests: XCTestCase {

    // MARK: - NAMING test_nameOfClassTested_nameOfFunctionTested -
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_PopularViewModel_getMovie() throws {
        
        let popularViewModel = PopularViewModel()
        
        popularViewModel.getMovie(with: 550)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(popularViewModel.selectedMovie?.id, 550)
        }
    }
    
    func test_PopularViewModel_getActor() throws {
        
        let popularViewModel = PopularViewModel()
        
        popularViewModel.getActor(with: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(popularViewModel.selectedActor?.id, 1)
        }
    }
    
    func test_PopularViewModel_getCast() throws {
        
        let popularViewModel = PopularViewModel()
        
        popularViewModel.getCast(with: 550)
        
        XCTAssertEqual(popularViewModel.cast.cast.count, 0)
        
    }
    

}
