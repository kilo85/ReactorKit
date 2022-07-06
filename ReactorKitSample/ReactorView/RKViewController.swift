//
//  RKViewController.swift
//  ReactorKitSample
//
//  Created by 하길호 on 2022/07/06.
//

import Foundation

import Foundation
import UIKit

private let collectionViewReuseIdentifier = "CollectionViewCell"
private let tableViewReuseIdentifier = "TableViewCell"

class RKViewController: UIViewController,
                            UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
                            UITableViewDelegate, UITableViewDataSource {
    let sectionInsets = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 10)  // 실제로 top만 갖다 씀
    
    let collectionList = ["전체", "매미", "사마귀", "존나큰사마귀", "개미", "나비"]
    let tableList: [String] = ["매미1", "사마귀", "매미1", "개미", "나비", "나비1" ,"하루살이" ,"매미8", "개미2", "매미10", "매미11"]
    var filteredList: [String] = [""]
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "ReactorKit ViewController kilo1"
        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.yellow

        return collectionView
    }()
    
    private let tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self 생략 가능
        view.backgroundColor = UIColor.white
        view.addSubview(nameLabel)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        setupView()
        
        collectionView.register(RKCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(RKTableViewCell.self, forCellReuseIdentifier: tableViewReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        //초기값
        filteredList = tableList
    }
    
    func setupView() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100)
        ])
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            // 높이는 60으로 계산
            collectionView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 80)
        ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        NSLayoutConstraint.activate([
           tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
           tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
           tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
           tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    // collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewReuseIdentifier, for: indexPath) as! RKCollectionViewCell

//        cell.label.text = "메뉴 + \(indexPath.row)"
        cell.label.text = collectionList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let string: String = "kilo selected \(indexPath.row)"
        nameLabel.text = string
        
        //array를 바꿔주고 tableView reload
        if (collectionList[indexPath.row] == "전체") {
            filteredList = tableList
        } else {
            let newList = tableList.filter { $0.contains(collectionList[indexPath.row]) }
            filteredList = newList
        }
        print(filteredList)
        tableView.reloadData()
    }
    
    // collectionViewCell의 width height를 명시적으로 정함 -> label의 크기만큼 유동적으로 동작하게..
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let itemsPerColumn: CGFloat = 1
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewReuseIdentifier, for: indexPath) as? RKCollectionViewCell else {
            return .zero
        }
        cell.label.text = collectionList[indexPath.row]
        // ✅ sizeToFit() : 텍스트에 맞게 사이즈가 조절
        cell.label.sizeToFit()

        // ✅ cellWidth = 글자수에 맞는 UILabel 의 width + 20(여백)
        let cellWidth = cell.label.frame.width + 20
        let cellHeight = (height - heightPadding) / itemsPerColumn

        return CGSize(width: cellWidth, height: cellHeight)
        
    }

    // tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewReuseIdentifier, for: indexPath) as! RKTableViewCell
        cell.label.text = filteredList[indexPath.row]
        return cell
    }

}
