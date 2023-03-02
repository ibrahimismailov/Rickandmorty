//
//  MockRickAndMortyView.swift
//  RickandmortyTests
//
//  Created by Abraam on 02.03.2023.
//

import UIKit
@testable import Rickandmorty

class MockRickAndMortyView: RickanMortyViewInterface {
    var isDragging: Bool = false
    var tableViewPrepared = false
    var searchBarPrepared = false
    
    func prepareTableView() {
        tableViewPrepared = true
        
    }
    
    func prepareSearchBar() {
        searchBarPrepared = true
    }
    
    func prepareRefreshControll() {
        
    }
    
    func beginRefreing() {
        
    }
    
    func endRefreshing() {
        
    }
    
    func reloadData() {
        
    }
    
    func goToDetail(to ViewController: UIViewController, animated: Bool) {
        
    }
    
    
}
