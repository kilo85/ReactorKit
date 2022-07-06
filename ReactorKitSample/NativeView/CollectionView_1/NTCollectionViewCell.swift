//
//  CollectionViewCell.swift
//  ReactorKitSample
//
//  Created by 하길호 on 2022/07/06.
//

import Foundation
import UIKit

class NTCollectionViewCell_1: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.backgroundColor = .green
        self.addSubview(imageView)  // 순서가 중요하다... add SubView를 하고 constraints를 맞춰야 한다
        
        imageView.contentMode = .scaleToFill
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 10
//        imageView.layer.masksToBounds = true

        
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
    
    
}
