//
//  DetailViewController.swift
//  Rickandmorty
//
//  Created by Abraam on 23.11.2022.
//

import UIKit
import SDWebImage
protocol DetailViewControllerInterface: AnyObject {
    func addSubViews()
    func configureViews(with model: RickanMortyModelResult)
}
final class DetailViewController: UIViewController {
    
    private lazy var viewModel = DetailViewControllerViewModel()
    private lazy var imageRickan = RickonImageView(frame: .zero)
    private lazy var labelRickan: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    }()
    private lazy var genderRickan = ReusableLabel(frame: .zero)
    private lazy var statusRickan = ReusableLabel(frame: .zero)
    private lazy var specRickan = ReusableLabel(frame: .zero)
    private lazy var originRickan = ReusableLabel(frame: .zero)
    
    override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.view = self
    viewModel.viewDidLoad()
       
    }
}
    //MARK: - DetailViewControllerConstraints
extension DetailViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            imageRickan.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 20),
            imageRickan.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 20),
            imageRickan.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -20),
            imageRickan.heightAnchor.constraint(
            equalToConstant: view.frame.size.width/2),
            
            labelRickan.topAnchor.constraint(
            equalTo: imageRickan.bottomAnchor,
            constant: 50),
            labelRickan.leadingAnchor.constraint(
            equalTo: imageRickan.leadingAnchor,
            constant: 20),
            labelRickan.trailingAnchor.constraint(
            equalTo: imageRickan.trailingAnchor,
            constant: -20),
            
            genderRickan.topAnchor.constraint(
            equalTo: labelRickan.bottomAnchor,
            constant: 30),
            genderRickan.leadingAnchor.constraint(
            equalTo: imageRickan.leadingAnchor,
            constant: 20),
            
            
            specRickan.topAnchor.constraint(
            equalTo: genderRickan.bottomAnchor,
            constant: 30),
            specRickan.leadingAnchor.constraint(
            equalTo: imageRickan.leadingAnchor,
            constant: 20),
            
            originRickan.topAnchor.constraint(
            equalTo: specRickan.bottomAnchor,
            constant: 30),
            originRickan.leadingAnchor.constraint(
            equalTo: imageRickan.leadingAnchor,
            constant: 20),
            
            statusRickan.topAnchor.constraint(
            equalTo: originRickan.bottomAnchor,
            constant: 30),
            statusRickan.leadingAnchor.constraint(
            equalTo: imageRickan.leadingAnchor,
            constant: 20),
            
        ])
    }
}
    //MARK: - DetailViewControllerInterface
extension DetailViewController: DetailViewControllerInterface {
    func addSubViews() {
        title =  "About"
        view.backgroundColor = .systemBackground
        view.addSubview(imageRickan)
        view.addSubview(labelRickan)
        view.addSubview(genderRickan)
        view.addSubview(statusRickan)
        view.addSubview(specRickan)
        view.addSubview(originRickan)
    }
    func configureViews(with model: RickanMortyModelResult) {
        imageRickan.sd_setImage(with: URL(string: model.image ?? "") )
        labelRickan.text = "My name is \(model.name ?? "Name")"
        genderRickan.text = "Gender : \(model.gender?.rawValue ?? "")"
        statusRickan.text = "Status : \(model.status?.rawValue ?? "")"
        specRickan.text = "Species : \(model.species?.rawValue ?? "")"
        originRickan.text = "Origin : \(model.origin?.name ?? "")"
    }
    
    
}
