//
//  MockRickAndMortyService.swift
//  RickandmortyTests
//
//  Created by Abraam on 02.03.2023.
//

import Foundation
@testable import Rickandmorty

class MockRickAndMortyService: RickanMortyServiceProtocol {
    func fetchCharacters(page: Int, completion: @escaping (Result<[Rickandmorty.RickanMortyModelResult], Rickandmorty.ErrorMessage>) -> Void) {
        
    }
    
    func searchCharacterByName(page: Int, searchText: String, completion: @escaping (Result<[Rickandmorty.RickanMortyModelResult], Rickandmorty.ErrorMessage>) -> ()) {
        
    }
    
    func getFilteredCharacter(name: String, gender: String, status: String, species: String, completion: @escaping (Result<[Rickandmorty.RickanMortyModelResult], Rickandmorty.ErrorMessage>) -> Void) {
        
    }
    
    
}
