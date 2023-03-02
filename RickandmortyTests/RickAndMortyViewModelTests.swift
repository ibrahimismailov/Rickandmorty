//
//  RickandmortyTests.swift
//  RickandmortyTests
//
//  Created by Abraam on 02.03.2023.
//

import XCTest
@testable import Rickandmorty

final class RickAndMortyViewModelTests: XCTestCase {
    
    var view = MockRickAndMortyView()
    var service = MockRickAndMortyService()
    lazy var viewModel = RickandmortyViewModel(view: view, service: service)

    override func setUpWithError() throws {
         view = MockRickAndMortyView()
         service = MockRickAndMortyService()
         viewModel = RickandmortyViewModel(view: view, service: service)
    }

    override func tearDownWithError() throws {

    }

    func test_tableView_prepared_on_viewDidload() throws {

        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.tableViewPrepared)
    }
    
    func test_searchBar_prepared_on_viewDidload() throws {
        
        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.searchBarPrepared)
    }

}




