//
//  RickandMortyTableViewCell.swift
//  Rickandmorty
//
//  Created by Abraam on 22.11.2022.
//

import UIKit
import SDWebImage
final class RickandMortyTableViewCell: UITableViewCell {
    static let identifier = "RickandMortyTableViewCell"
    

     let rickonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
     let rickonNameLabel: UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 20, weight: .semibold)
         label.numberOfLines = 0
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let rickonStatusLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    let speciesLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    let genderLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        addSubview(rickonImageView)
        addSubview(rickonNameLabel)
        addSubview(rickonStatusLabel)
        addSubview(speciesLabel)
        addSubview(genderLabel)
    }
    func configure(with model: RickanMortyModelResult) {
        self.rickonImageView.sd_setImage(with: URL(string: model.image ?? ""))
        self.rickonNameLabel.text = model.name ?? ""
        self.rickonStatusLabel.text = "Status : \(model.status ?? "")"
        self.genderLabel.text = "Gender : \(model.gender ?? "")"
        self.speciesLabel.text = "Species : \(model.species ?? "")"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    //MARK: - RickandMortyTableViewCell Constraints
extension RickandMortyTableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            
        rickonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        rickonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
        rickonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
        rickonImageView.heightAnchor.constraint(equalToConstant: 100),
     

        rickonNameLabel.topAnchor.constraint(equalTo: rickonImageView.bottomAnchor, constant: 10),
        rickonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        rickonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        

        rickonStatusLabel.topAnchor.constraint(equalTo: rickonNameLabel.bottomAnchor, constant: 10),
        rickonStatusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        rickonStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        
        genderLabel.topAnchor.constraint(equalTo: rickonStatusLabel.bottomAnchor, constant: 10),
        genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        genderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        
        
        speciesLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
        speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
 
        
        ])
    }
}
