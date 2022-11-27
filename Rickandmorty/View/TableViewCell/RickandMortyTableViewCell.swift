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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
     let rickonNameLabel: UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 16, weight: .semibold)
         label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let rickonStatusLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(rickonImageView)
        addSubview(rickonNameLabel)
        addSubview(rickonStatusLabel)
    }
    func configure(with model: RickanMortyModelResult) {
        self.rickonImageView.sd_setImage(with: URL(string: model.image ?? ""))
        self.rickonNameLabel.text = model.name ?? ""
        self.rickonStatusLabel.text = model.status ?? ""
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
        rickonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        rickonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        rickonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        rickonImageView.heightAnchor.constraint(equalToConstant: 70),
        rickonImageView.widthAnchor.constraint(equalToConstant: 70),
        
        rickonNameLabel.topAnchor.constraint(equalTo: rickonImageView.topAnchor, constant: 10),
        rickonNameLabel.leadingAnchor.constraint(equalTo: rickonImageView.trailingAnchor, constant: 20),
        rickonNameLabel.widthAnchor.constraint(equalToConstant: 200),
        
        rickonStatusLabel.topAnchor.constraint(equalTo: rickonNameLabel.bottomAnchor, constant: 10),
        rickonStatusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        rickonStatusLabel.leadingAnchor.constraint(equalTo: rickonImageView.trailingAnchor, constant: 20),
        rickonStatusLabel.widthAnchor.constraint(equalToConstant: 200),
        
        ])
    }
}
