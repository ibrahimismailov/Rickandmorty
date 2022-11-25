//
//  RickanMortyService.swift
//  Rickandmorty
//
//  Created by Abraam on 23.11.2022.
//
//https://rickandmortyapi.com/api/character/?name=rick&status=alive
import Foundation
import Alamofire
enum RickanMortyServiceEndPoints: String {
    case BASE_URL = "https://rickandmortyapi.com/api/"
    case PATH = "character/"
    case base = "https://rickandmortyapi.com/api/character/"
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol RickanMortyServiceProtocol {
    func fetchCharacters(page: Int,completion: @escaping (Result<[RickanMortyModelResult],ErrorMessage>) -> Void)

}
    
class RickanMortyService: RickanMortyServiceProtocol {
    static let shared = RickanMortyService()
    
        //MARK: - fetchCharacters
    func fetchCharacters(page: Int, completion: @escaping (Result<[RickanMortyModelResult], ErrorMessage>) -> Void) {
        let endpoint = RickanMortyServiceEndPoints.characterPath()
        guard let url = URL(string: endpoint)else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characters = try decoder.decode(RickanMortyModel.self, from: data)
                completion(.success(characters.results))
            }catch{
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    func searchCharacterByName(page: Int, searchText: String, completion : @escaping (Result<[RickanMortyModelResult] , ErrorMessage>)->()){
        let endpoint = RickanMortyServiceEndPoints.characterPath() + "?name=\(searchText.replacingOccurrences(of: " ", with: "+"))&page=\(page)"
        guard let url = URL(string: endpoint)else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characters = try decoder.decode(RickanMortyModel.self, from: data)
                completion(.success(characters.results))
            }catch{
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    func getFilteredCharacters(gender : String, status : String, completed : @escaping(Result<[RickanMortyModelResult] , ErrorMessage>)->()){
       let endPoint =  "https://rickandmortyapi.com/api/character/?page=2&name=rick&status=\(status)&gender=\(gender)"
       // let endpoint = RickanMortyServiceEndPoints.characterPath() + "?gender=\(gender)" + "&status=\(status)"
        
        guard let url = URL(string: endPoint)else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characters = try decoder.decode(RickanMortyModel.self, from: data)
                completed(.success(characters.results))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    }
    
  
    

    //?name=rick&status=alive
//    func searchCharacterByFilter( searchText: String,gender : String , status : String, completion : @escaping (Result<[RickanMortyModelResult] , ErrorMessage>)->()){
//        let endpoint = RickanMortyServiceEndPoints.characterPath() + "?name=\(searchText.replacingOccurrences(of: " ", with: "+"))&status\(status)&gender\(gender)"
//        guard let url = URL(string: endpoint)else{
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completion(.failure(.unableToComplete))
//            }
//            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let characters = try decoder.decode(RickanMortyModel.self, from: data)
//                completion(.success(characters.results))
//            }catch{
//                completion(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
    
        //MARK: - filterSearch
//    func getFilteredCharacters(gender : String , status : String, completed : @escaping(Result<[RickanMortyModelResult] , ErrorMessage>)->()){
//        let endpoint = RickanMortyServiceEndPoints.characterPath() + "?gender=\(gender)" + "&status=\(status)"
//
//        guard let url = URL(string: endpoint)else{
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//            }
//            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let characters = try decoder.decode(RickanMortyModel.self, from: data)
//                completed(.success(characters.results))
//            }catch{
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
    
    
    
   

