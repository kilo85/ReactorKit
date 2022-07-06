//
//  CollectionViewCell.swift
//  ReactorKitSample
//
//  Created by 하길호 on 2022/07/06.
//

import Foundation
import UIKit

class RKCollectionViewCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.backgroundColor = .gray
        self.addSubview(label)  // 순서가 중요하다... add SubView를 하고 constraints를 맞춰야 한다
        
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
