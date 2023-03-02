//
//  RickandmortyViewModel.swift
//  Rickandmorty
//
//  Created by Abraam on 23.11.2022.
//
import UIKit
import SDWebImage
protocol RickandmortyViewModelProtocol {
    var  view: RickanMortyViewInterface? { get set }
    func viewDidLoad()
    func viewWillAppear()
    func pulledDownRefreshControl()
    func scrollViewDidEndDecelerating()
    func didSelectItemAt (at indexPath: IndexPath)
    func callCharacters(searchBar: UISearchBar,textDidChange: String)
    func applyButtonTapped(name: String, gender: String,status: String,species: String)
    
}

final class RickandmortyViewModel {
    
    internal init(view: RickanMortyViewInterface?, service: RickanMortyServiceProtocol) {
        self.view = view
        self.service = service
    }
    
    
  weak  var view: RickanMortyViewInterface?
  lazy var model = [RickanMortyModelResult]()
  lazy var popUp = FilterPopUp()
  let service: RickanMortyServiceProtocol
 
  private lazy var page = 1...42
  private var shouldNeddToCallPulledDownRefreshControll: Bool = false
    
    func fetchCharacters() {
        guard let page = page.randomElement() else {return}
        view?.beginRefreing()
        service.fetchCharacters(page: page) { [weak self] model in
            switch model {
            case.success(let model):
                self?.model = model
                DispatchQueue.main.async {
                    self?.view?.reloadData()
                    self?.view?.endRefreshing()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func callCharacterByName(_ searchBar: UISearchBar, textDidChange searchText: String){
        service.searchCharacterByName(page: page.randomElement()!, searchText: searchText) {[weak self] result in
                    switch result{
                    case .success(let characters):
                        self?.model = characters
                        DispatchQueue.main.async {
                            self?.view?.reloadData()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self?.view?.reloadData()
                        }
                    }
                }
            }

    func callCharacterWithFilter(name: String, gender: String,status: String,species: String) {
        service.getFilteredCharacter(name: name, gender: gender, status: status, species: species) {[weak self] result in
            switch result {
                case .success(let success):
                self?.model = success
                DispatchQueue.main.async {
                self?.view?.reloadData()
                }
                case .failure(let error):
                print(error.localizedDescription)
                }
        }
    }
}

extension RickandmortyViewModel: RickandmortyViewModelProtocol {
    func viewDidLoad() {
        
        view?.prepareTableView()
        view?.prepareSearchBar()
        fetchCharacters()
    }
    
    func viewWillAppear() {
        view?.prepareRefreshControll()
    }
    
    func pulledDownRefreshControl() {
        guard let isDragging = view?.isDragging, !isDragging else {
            shouldNeddToCallPulledDownRefreshControll = true
            return
        }
        fetchCharacters()
    }
    
    func scrollViewDidEndDecelerating() {
        guard shouldNeddToCallPulledDownRefreshControll else {return}
        shouldNeddToCallPulledDownRefreshControll = false
        fetchCharacters()
    }
    
    func didSelectItemAt(at indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.configureViews(with: model[indexPath.row])
        view?.goToDetail(to: vc, animated: true)

    }
    
    func callCharacters(searchBar: UISearchBar,textDidChange: String) {
        callCharacterByName(searchBar, textDidChange: textDidChange)
    }
    
    func applyButtonTapped(name: String, gender: String,status: String,species: String) {
        callCharacterWithFilter(name: name, gender: gender, status: status, species: species)
        popUp.removeFromSuperview()
    }
}

