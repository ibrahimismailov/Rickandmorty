
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
