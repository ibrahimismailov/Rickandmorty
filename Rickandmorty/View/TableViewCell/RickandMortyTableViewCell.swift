//
//  RickandMortyTableViewCell.swift
//  Rickandmorty
//
//  Created by Abraam on 22.11.2022.
//

import UIKit

class RickandMortyTableViewCell: UITableViewCell {
    static let identifier = "RickandMortyTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
