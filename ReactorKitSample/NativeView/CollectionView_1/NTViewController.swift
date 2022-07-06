//
//  RTViewController.swift
//  ReactorKitSample
//
//  Created by 하길호 on 2022/07/06.
//

import Foundation
import UIKit

private let reuseIdentifier = "Cell"

class NTViewController_1: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Native ViewController kilo1"
        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blue

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self 생략 가능
        view.backgroundColor = UIColor.white
        view.addSubview(nameLabel)
        view.addSubview(collectionView)
        
        setupView()
        
        collectionView.register(NTCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50).isActive = true
        nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50).isActive = true
        collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        // 높이는 100으로 계산
        collectionView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 120).isActive = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

                         
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NTCollectionViewCell_1

        cell.imageView.image = UIImage(systemName: "heart")

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let string: String = "kilo selected \(indexPath.row)"
        
        nameLabel.text = string
    }

}
