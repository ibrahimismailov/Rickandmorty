
//  RickanMortyModel.swift
//  Rickandmorty
//  Created by Abraam on 23.11.2022.

import Foundation

// MARK: - RickanMortyModel
struct RickanMortyModel: Codable {
    let info: Info?
    let results: [RickanMortyModelResult]
}
struct Info: Codable {
    let count, pages: Int?
    let next: String?
}
// MARK: - RickanMortyModelResult
struct RickanMortyModelResult: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
}
enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

struct CharacterListViewModel {
    var resultList : [RickanMortyModelResult]
    
    
    func numberOfRowAt ()-> Int {
        return resultList.count
    }
    func cellForRowAt(_ index : Int) -> CharacterViewModel{
        let character = resultList[index]
        return CharacterViewModel(character)
    }
    mutating func searchNotFound(){
        self.resultList = []
    }
}
struct CharacterViewModel{
    
    let result : RickanMortyModelResult
    
    init(_ result : RickanMortyModelResult){
        self.result = result
    }
    
    var id : Int {
        return self.result.id ?? 0
    }
    var name : String {
        return self.result.name ?? ""
    }
    var status : String{
        return self.result.status?.rawValue ?? ""
    }
    var species : String {
        return self.result.species?.rawValue ?? ""
    }
    var type : String {
        return self.result.type ?? ""
    }
    var gender : String {
        return self.result.type ?? ""
    }
    var image : String {
        return self.result.image ?? ""
    }

    
}
