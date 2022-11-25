//
//  rickonImageView+Extension.swift
//  Rickandmorty
//
//  Created by Abraam on 24.11.2022.
//

import UIKit

  class RickonImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    func setupImageView(){
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
