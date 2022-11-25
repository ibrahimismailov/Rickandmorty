//
//  RickandmortyViewModel.swift
//  Rickandmorty
//
//  Created by Abraam on 23.11.2022.
//

import UIKit
import SDWebImage
protocol RickandmortyViewModelProtocol {
    var view: RickanMortyViewInterface? { get set }
    func viewDidLoad()
    func viewWillAppear()
    func pulledDownRefreshControl()
    func scrollViewDidEndDecelerating()
    func didSelectItemAt (at indexPath: IndexPath)
}

final class RickandmortyViewModel {
    
  weak  var view: RickanMortyViewInterface?
  lazy var model = [RickanMortyModelResult]()
  private lazy var page = 1...42
    
    private var shouldNeddToCallPulledDownRefreshControll: Bool = false
    func fetchCharacters() {
        guard let page = page.randomElement() else {return}
        view?.beginRefreing()
        RickanMortyService.shared.fetchCharacters(page: page) { [weak self] model in
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
        //vc.configure(with: model[indexPath.row] )
        view?.goToDetail(to: vc, animated: true)

    }
    
}
