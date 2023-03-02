//
//  MockRickAndMortyService.swift
//  RickandmortyTests
//
//  Created by Abraam on 02.03.2023.
//

import Foundation
@testable import Rickandmorty

class MockRickAndMortyService: RickanMortyServiceProtocol {
    var fetchCharactersAreCalled = false
    var sampleCharacters = [
        RickanMortyModelResult(id: 1, name: "name1", status: "dead", species: "Human", type: "", gender: "male", image: nil, location: Location(name: "earth", url: nil), episode: []),
        RickanMortyModelResult(id: 2, name: "name2", status: "alive", species: "Human", type: "", gender: "male", image: nil, location: Location(name: "earth", url: nil), episode: []),
        RickanMortyModelResult(id: 3, name: "name3", status: "dead", species: "Human", type: "", gender: "female", image: nil, location: Location(name: "earth", url: nil), episode: [])
    ]
    
    let deliveredQues = DispatchQueue(label: "")
    
    func fetchCharacters(page: Int, completion: @escaping (Result<[Rickandmorty.RickanMortyModelResult], Rickandmorty.ErrorMessage>) -> Void) {
        fetchCharactersAreCalled = true
        deliveredQues.async {
            completion(.success(self.sampleCharacters))
        }
    }
    
    func searchCharacterByName(page: Int, searchText: String, completion: @escaping (Result<[Rickandmorty.RickanMortyModelResult], Rickandmorty.ErrorMessage>) -> ()) {
        
    }
    
    func getFilteredCharacter(name: String, gender: String, status: String, species: String, completion: @escaping (Result<[Rickandmorty.RickanMortyModelResult], Rickandmorty.ErrorMessage>) -> Void) {
        let correctCharacters = sampleCharacters.filter{$0.name == name && $0.gender == gender && $0.status == status && $0.species == species}
        deliveredQues.async {
            completion(.success(correctCharacters))
        }
    }
    
    
}

extension RickanMortyModelResult: Equatable {
    public static func == (lhs: RickanMortyModelResult, rhs: RickanMortyModelResult) -> Bool {
        lhs == rhs
    }
}

extension Location: Equatable {
   public static func == (lhs: Location, rhs: Location) -> Bool {
        lhs == rhs
    }
}
