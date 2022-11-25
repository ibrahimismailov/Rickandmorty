//
//  SortTableViewCell.swift
//  Rickandmorty
//
//  Created by Abraam on 25.11.2022.
//

import UIKit
class SortTableViewCell: UITableViewCell {
    var isChecked: Bool = false
static let identifier = "SortTableViewCell"
    let texttLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(texttLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            texttLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            texttLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }
    func configureText(text: String) {
        texttLabel.text = text
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
