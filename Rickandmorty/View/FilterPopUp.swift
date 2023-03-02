//
//  FilterPopUp.swift
//  Rickandmorty
//
//  Created by Abraam on 25.11.2022.
//

import UIKit
class FilterPopUp: UIView  {
    let searchController = UISearchController(searchResultsController: nil)
   private lazy var genderSection = "Gender"
   private lazy var statusSection = "Status"
   private lazy var spaciesSection = "Spacies"

    private lazy var genderText = ["male","female","genderless","unknown"]
    private lazy var statusText = ["alive", "dead","unknown"]
    private lazy var spaciesText = ["alien", "human","unknown"]
    
    var selectedGender = ""
    var selectedStatus = ""
    var selectedSpacies = ""
    
    let conteiner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0.2, height: 0.3)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 1
        return view
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 10
        tableView.register(
        SortTableViewCell.self,
        forCellReuseIdentifier: SortTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        return tableView
    }()
    
     let applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        addSubview(conteiner)
        
        conteiner.addSubview(applyButton)
        conteiner.addSubview(tableView)
        tableView.delegate  = self
        tableView.dataSource = self
        tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.tableHeaderView = searchController.searchBar

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            conteiner.centerXAnchor.constraint(
            equalTo: self.centerXAnchor),
            conteiner.centerYAnchor.constraint(
            equalTo: self.centerYAnchor),
            conteiner.widthAnchor.constraint(
            equalTo: self.widthAnchor,
            multiplier: 1.0),
            conteiner.heightAnchor.constraint(
            equalTo: self.heightAnchor,
            multiplier: 0.76),
           
            tableView.topAnchor.constraint(
            equalTo: conteiner.topAnchor,
            constant: 40),
            tableView.leadingAnchor.constraint(
            equalTo: conteiner.leadingAnchor),
            tableView.trailingAnchor.constraint(
            equalTo: conteiner.trailingAnchor),
            tableView.heightAnchor.constraint(
            equalToConstant: 520),
            
            applyButton.topAnchor.constraint(
            equalTo: tableView.bottomAnchor,
            constant: 20),
            applyButton.leadingAnchor.constraint(
            equalTo: conteiner.leadingAnchor,
            constant: 20),
            applyButton.trailingAnchor.constraint(
            equalTo: conteiner.trailingAnchor,
            constant: -20),
          
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FilterPopUp: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int
    ) -> Int {
        switch section {
        case 0: return genderText.count
        case 1: return statusText.count
        case 2: return spaciesText.count
        default:
            break
        }
        return 1
    }
    func tableView(_ tableView: UITableView,
       cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
        withIdentifier:SortTableViewCell.identifier,
        for: indexPath) as? SortTableViewCell else
        {
            return  UITableViewCell()
        }
        switch indexPath.section {
        case 0: cell.texttLabel.text = genderText[indexPath.row]
        case 1: cell.texttLabel.text = statusText[indexPath.row]
        case 2: cell.texttLabel.text = spaciesText[indexPath.row]
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView,
       titleForHeaderInSection section: Int
    ) -> String?
    {
        switch section {
        case 0: return genderSection
        case 1: return statusSection
        case 2: return spaciesSection
        default:
            break
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: cell.contentView.frame.width, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.09 *  Double(indexPath.row),options: .curveEaseInOut){
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
  
    func tableView(_ tableView: UITableView,
       didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath,
        animated: true)
        if tableView.cellForRow(
        at: indexPath)?.accessoryType == .checkmark
        {
     
        tableView.cellForRow(
        at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(
            at: indexPath)?.accessoryType = .checkmark
            switch indexPath.section {
            case 0: self.selectedGender = genderText[indexPath.row]
            case 1: self.selectedStatus = statusText[indexPath.row]
            case 2: self.selectedSpacies = spaciesText[indexPath.row]
            default: break
            }
        }
      
    }
   
   
}

