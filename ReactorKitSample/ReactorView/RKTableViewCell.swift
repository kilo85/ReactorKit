//
//  NTTableViewCell.swift
//  ReactorKitSample
//
//  Created by 하길호 on 2022/07/06.
//

import Foundation
import UIKit

class RKTableViewCell: UITableViewCell {
    // imageView 생성
    private let img: UIImageView = {
        let imgView = UIImageView()
//        imgView.image = UIImage(named: "icon")
        imgView.image = UIImage(systemName: "heart")
        return imgView
    }()

    // label 생성
    let label: UILabel = {
        let label = UILabel()
//        label.text = "상어상어"
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        contentView.addSubview(img)
        contentView.addSubview(label)

        img.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            img.widthAnchor.constraint(equalToConstant: 64),
            img.heightAnchor.constraint(equalToConstant: 64),
            label.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: img.centerYAnchor)
        ])
    }
}
