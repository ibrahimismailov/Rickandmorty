
//  Rickandmorty
//  Created by Abraam on 22.11.2022.
import UIKit
import SDWebImage

protocol RickanMortyViewInterface: AnyObject {
    var  isDragging: Bool { get }
    func prepareTableView()
    func prepareSearchBar()
    func prepareRefreshControll()
    func beginRefreing()
    func endRefreshing()
    func reloadData()
    func goToDetail(
    to ViewController: UIViewController,
    animated: Bool)
}

class RickandmortyViewController: UIViewController {
    
    private lazy var viewModel = RickandmortyViewModel()
    private lazy var searchBar: UISearchController  = UISearchController()
    private  var gendertText: String = ""
    private var statusText: String = ""
    
    private let RickontableView: UITableView = {
        let table  = UITableView(frame: .zero, style: .insetGrouped)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
    
    @objc private func pulledDownRefreshControl() {
        viewModel.pulledDownRefreshControl()
    }
    
}
    //MARK: - UIScrollViewDelegate
extension RickandmortyViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.scrollViewDidEndDecelerating()
    }
}

    //MARK: - TableViewDelegate&DataSource
extension RickandmortyViewController: UITableViewDelegate,
                                      UITableViewDataSource
{
    func tableView(_ tableView: UITableView,
         numberOfRowsInSection section: Int
    ) -> Int
    {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell
    {
    guard let cell = tableView.dequeueReusableCell(
    withIdentifier: RickandMortyTableViewCell.identifier,
    for: indexPath) as? RickandMortyTableViewCell else {
        return UITableViewCell()
    }
    cell.configure(with: viewModel.model[indexPath.row])
    return cell
    }
  
    func tableView(_ tableView: UITableView,
         didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(
        at: indexPath,
        animated: true)
        viewModel.didSelectItemAt(at: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

    //MARK: - UISearchBarDelegate
 extension RickandmortyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
         textDidChange searchText: String
    ) {
        viewModel.callCharacters(
        searchBar: searchBar,
        textDidChange: searchText)
    }
}

    //MARK: - RickonMortyViewInterface
extension RickandmortyViewController: RickanMortyViewInterface {
   
    func goToDetail(
        to viewController: UIViewController,
        animated: Bool
    ) {
        navigationController?.pushViewController(
        viewController,
        animated: true)
    }
    
    func prepareSearchBar() {
        self.navigationItem.searchController = self.searchBar
        self.searchBar.searchBar.delegate = self
    let rightBarButton = UIBarButtonItem(
        image: UIImage(
        systemName: "slider.vertical.3")?.withRenderingMode(
        .alwaysTemplate),
         style: .done,
         target: self,
         action: #selector(tappedFilter))
        rightBarButton.tintColor = UIColor(named: "filter")
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
        @objc private func tappedFilter() {
            self.searchBar.searchBar.isHidden = true
        view.addSubview(viewModel.popUp)
        viewModel.popUp.applyButton.addTarget(self,
        action: #selector(tappedApplyButton),
        for: .touchUpInside)
        }
    @objc  func tappedApplyButton() {
        self.searchBar.searchBar.isHidden = false
        guard let name = viewModel.popUp.searchController.searchBar.text else {return}
        let gender = viewModel.popUp.selectedGender
        let status = viewModel.popUp.selectedStatus
        let spacies = viewModel.popUp.selectedSpacies
        viewModel.callCharacterWithFilter(name: name, gender: gender, status: status, species: spacies)
        viewModel.popUp.removeFromSuperview()
        
        }
    
    func prepareTableView() {
        view.addSubview(RickontableView)
        RickontableView.separatorStyle = .none
        RickontableView.translatesAutoresizingMaskIntoConstraints = false
        RickontableView.delegate = self
        RickontableView.dataSource = self
        RickontableView.rowHeight = 120.0
        RickontableView.register(
        RickandMortyTableViewCell.self,
        forCellReuseIdentifier: RickandMortyTableViewCell.identifier
        )
        RickontableView.reloadData()
    }
    
    func prepareRefreshControll() {
        let refreshControll = UIRefreshControl()
        refreshControll.tintColor = .systemGray
        refreshControll.addTarget(
        self,
        action: #selector(pulledDownRefreshControl),
        for: .valueChanged)
        RickontableView.refreshControl = refreshControll
    }
    
    var isDragging: Bool {RickontableView.isDragging}
    
    func beginRefreing() {
        RickontableView.refreshControl?.beginRefreshing()
    }
    
    func endRefreshing() {
        RickontableView.refreshControl?.endRefreshing()
    }
    
    func reloadData() {
        RickontableView.reloadData()
    }
    
    func searchBars(_ searchBar: UISearchBar,
        textDidChange searchText: String
    ){
        viewModel.callCharacters(
        searchBar: searchBar,
        textDidChange: searchText)
            }
    }
    
    //MARK: - Constraints
    extension RickandmortyViewController {
        func makeConstraints() {
        NSLayoutConstraint.activate ([
        RickontableView.topAnchor.constraint(
        equalTo: view.topAnchor,
        constant: 0),
        RickontableView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor),
        
        RickontableView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor),
        RickontableView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor),
        ])
        }

    }

