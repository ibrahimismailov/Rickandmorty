
//  RickanMortyModel.swift
//  Rickandmorty
//  Created by Abraam on 23.11.2022.

import Foundation

struct RickanMortyModel: Decodable {
    let info: Info?
    let results: [RickanMortyModelResult]?
}

struct Info: Decodable {
    let count, pages: Int?
    let next, prev: String?
}
struct RickanMortyModelResult  : Decodable {
    let id : Int?
    let name : String?
    let status : String?
    let species : String?
    let type : String?
    let gender : String?
    let image : String?
    let location : Location
    let episode : [String]
}
struct Location : Decodable {
    let name : String?
    let url : String?
}

