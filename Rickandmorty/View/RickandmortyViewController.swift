//
//  ViewController.swift
//  Rickandmorty
//
//  Created by Abraam on 22.11.2022.
//

import UIKit

class RickandmortyViewController: UIViewController {
    // searchBar
    private let searchBar: UISearchController = {
        let searc = UISearchController()
        return searc
    }()
    // tableView
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
 
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeConstraints()
       
    }
    func configureVC(){
        DispatchQueue.main.async {
            self.title = "Characters"
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.view.backgroundColor = .systemBackground
            self.navigationItem.searchController = self.searchBar
        }
    }
    func configureTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
        UITableViewCell.self,
        forCellReuseIdentifier: "cell"
        )
    }
}
    //MARK: - TableViewDelegate&DataSource
extension RickandmortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row) Ricky"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    //MARK: - Constraints
extension RickandmortyViewController {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
}

