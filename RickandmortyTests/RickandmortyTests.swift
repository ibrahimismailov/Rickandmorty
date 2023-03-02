//
//  RickandmortyTests.swift
//  RickandmortyTests
//
//  Created by Abraam on 02.03.2023.
//

import XCTest
@testable import Rickandmorty

final class RickandmortyTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {
        let view = MockRickAndMortyView()
        let service = MockRickAndMortyService()
        let viewModel = RickandmortyViewModel(view: view, service: service)
    }

}




