//
//  RickanMortyService.swift
//  Rickandmorty
//
//  Created by Abraam on 23.11.2022.

import Foundation
import Alamofire
enum RickanMortyServiceEndPoints: String {
    case BASE_URL = "https://rickandmortyapi.com/api/"
    case PATH = "character/"
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol RickanMortyServiceProtocol {
    func fetchCharacters(page: Int,completion: @escaping (Result<[RickanMortyModelResult],ErrorMessage>) -> Void)
    func searchCharacterByName(page: Int, searchText: String, completion : @escaping (Result<[RickanMortyModelResult] , ErrorMessage>)->())
   func getFilteredCharacter(gender: String,status: String, completion: @escaping (Result<[RickanMortyModelResult],Error>) -> Void)
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
        //MARK: - searchCharacterByName
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
        //MARK: - getFilteredCharacters
    
    func getFilteredCharacter(gender: String,status: String, completion: @escaping (Result<[RickanMortyModelResult],Error>) -> Void) {
           
           guard let url =  URL(string: "https://rickandmortyapi.com/api/character/?status=\(status)&gender=\(gender)")
                   else {
                   return
           }
               var request = URLRequest(url: url)
               request.httpMethod = "GET"
               URLSession.shared.dataTask(with: request){
               (data , response, error)  in
               guard let data = data, error == nil else {
               print(error?.localizedDescription ?? "No data")
               completion(.failure(error?.localizedDescription as! Error))
               return
               }
               guard let response = response else {
                   return
               }
               print(response)
               let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
             if let responseJSON = responseJSON as? [String: Any] {
                 do {
                     let postBody = try JSONDecoder().decode(RickanMortyModel.self, from: data)
                     print(postBody)
                     completion(.success(postBody.results))
                 }catch let error{
                     print(error.localizedDescription)
                 }
             print(responseJSON)
                         }
                   }.resume()
               }
    

    }

