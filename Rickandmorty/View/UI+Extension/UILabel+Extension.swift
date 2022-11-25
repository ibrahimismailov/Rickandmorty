//
//  UILabel+Extension.swift
//  Rickandmorty
//
//  Created by Abraam on 24.11.2022.
//

import UIKit
 class ReusableLabel: UILabel {
   override init(frame: CGRect) {
       super.init(frame: frame)
       configureLabel()
   }
   func configureLabel(){
       font = .monospacedDigitSystemFont(ofSize: 18, weight: .semibold)
       tintColor = .systemBrown
       numberOfLines = 0
       textAlignment = .center
       tintColor = .systemBrown
       translatesAutoresizingMaskIntoConstraints = false
   }
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}

