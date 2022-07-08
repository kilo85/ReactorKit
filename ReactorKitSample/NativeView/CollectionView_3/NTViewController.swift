//
//  RTViewController.swift
//  ReactorKitSample
//
//  Created by 하길호 on 2022/07/06.
//

// 1. collectionView 추가
// 2. tableView 연동

import Foundation
import UIKit

class SectionItem {
    var sectionName: String = "A"
    var showsSelf1: Bool = true
    var showsContents1: Bool = true
    var items1: [Item] = [Item]()
    
    init(sectionName:String, items: [Item]?) {
        self.sectionName = sectionName
        if let items = items { self.items1 = items }
    }
   
    func changeVisiblity(section: Int) -> [IndexPath] {
        showsContents1.toggle()
        items1.forEach { $0.showsSelf = showsContents1 }
        return items1.enumerated().map { IndexPath(row: $0.offset, section: section) }
    }
}

class Item {
    var name: String = "A"
    var showsSelf: Bool = true
    var showsContents: Bool = true
    var items: [Item] = [Item]()
    
    init(name : String) {
        self.name = name
    }
   
    func changeVisiblity(section: Int) -> [IndexPath] {
        showsContents.toggle()
        items.forEach { $0.showsSelf = showsContents }
        return items.enumerated().map { IndexPath(row: $0.offset, section: section) }
    }
}

private let collectionViewReuseIdentifier = "CollectionViewCell"
private let tableViewReuseIdentifier = "TableViewCell"
private let headerReuseIdentifier = "Header"
private let footerReuseIdentifier = "Footer"

class NTViewController: UIViewController {
    let sectionInsets = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 10)  // 실제로 top만 갖다 씀
    
    let collectionList = ["전체", "매미", "사마귀", "존나큰사마귀", "개미", "나비"]
    
//    var dArray = [SectionItem([Item(name: "매미1"), Item(name: "사마귀1"), Item(name: "하루살이1"), Item(name: "개미1")]),
//                  SectionItem([Item(name: "매미2"), Item(name: "사마귀2"), Item(name: "하루살이2"), Item(name: "매미8")]),
//                  SectionItem([Item(name: "매미3"), Item(name: "사마귀3"), Item(name: "하루살이3")])]
    
    var dArray: [SectionItem] = []
    var filteredList: [SectionItem] = []
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Native ViewController kilo2"
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
        
        //data 초기화
        dArray.append(SectionItem(sectionName: "섹션1", items: [Item(name: "매미1"), Item(name: "사마귀1"), Item(name: "하루살이1"), Item(name: "개미1")]))
        dArray.append(SectionItem(sectionName: "섹션2", items: [Item(name: "매미2"), Item(name: "사마귀2"), Item(name: "하루살이2"), Item(name: "개미2")]))
        dArray.append(SectionItem(sectionName: "섹션3", items: [Item(name: "매미3"), Item(name: "사마귀3"), Item(name: "하루살이3"), Item(name: "개미3")]))
        dArray.append(SectionItem(sectionName: "섹션4", items: [Item(name: "매미4"), Item(name: "사마귀4"), Item(name: "바퀴벌레4")]))
        
        //self 생략 가능
        view.backgroundColor = UIColor.white
        view.addSubview(nameLabel)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        setupView()
        
        collectionView.register(NTCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(NTTableViewCell.self, forCellReuseIdentifier: tableViewReuseIdentifier)
        tableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
        tableView.register(SectionFooter.self, forHeaderFooterViewReuseIdentifier: footerReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        //초기값
        filteredList = dArray
        
        
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        // 전체 tableView에 대한 Header, Footer
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        header.backgroundColor = .systemOrange
        footer.backgroundColor = .systemTeal
        
        let headerButton = UIButton(frame: header.bounds)
        headerButton.setTitle("Header", for: .normal)
        headerButton.titleLabel?.textAlignment = .center
        header.addSubview(headerButton)
        headerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let footerLabel = UILabel(frame: footer.bounds)
        footerLabel.text = "Footer"
        footerLabel.textAlignment = .center
        footer.addSubview(footerLabel)
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer

    }
    
    
    //미사용
    func getSection(header: UITableViewHeaderFooterView) -> Int? {
        let point = CGPoint(x: header.frame.midX, y: header.frame.midY)
        for s in 0 ..< dArray.count {
            if tableView.rectForHeader(inSection: s).contains(point) {
                return s
            }
        }
        return nil
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
    
    @objc func buttonTapped() {
        print("kilo1 buttonTapped")
//        guard let section = getSection(header: header) else { return }
        let section = 0
        let _ = dArray[section].changeVisiblity(section: section)
        
        // ここでアニメーション変えてみて
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }

}

// collectionViewDateSource
extension NTViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewReuseIdentifier, for: indexPath) as! NTCollectionViewCell

//        cell.label.text = "메뉴 + \(indexPath.row)"
        cell.label.text = collectionList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let string: String = "kilo selected \(indexPath.row)"
        nameLabel.text = string
        
        //array를 바꿔주고 tableView reload
        if (collectionList[indexPath.row] == "전체") {
            for i in 0 ..< dArray.count {
                for j in 0 ..< dArray[i].items1.count {
                    dArray[i].items1[j].showsSelf = true //조건 돌때마다 true
                }
            }
        } else {
            let searchString = collectionList[indexPath.row]
            
//            for문을 돌려서
            for i in 0 ..< dArray.count {
                for j in 0 ..< dArray[i].items1.count {
                    dArray[i].items1[j].showsSelf = true //조건 돌때마다 true
                    
                    print("kilo1 searchString : \(searchString)")
                    print("kilo1 name1 : \(dArray[i].items1[j].name)")
                    if (!dArray[i].items1[j].name.contains(searchString)) {
                        // 포함하지 않으면 false
                        dArray[i].items1[j].showsSelf = false
                    }
                }
            }
        }
        filteredList = dArray
        tableView.reloadData()
    }
    
    // collectionViewCell의 width height를 명시적으로 정함 -> label의 크기만큼 유동적으로 동작하게..
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let itemsPerColumn: CGFloat = 1
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewReuseIdentifier, for: indexPath) as? NTCollectionViewCell else {
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

}

// TableViewDateSource
extension NTViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO : 왜 5번이나 호출되지??
        let count = dArray.count
        print("kilo1 section count : \(count)")
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = dArray[section].items1.filter{ $0.showsSelf == true }.count
//        let count = dArray[section].items1.count
        return count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier) as! SectionHeader
        header.textLabel?.text = dArray[section].sectionName

        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        let view: UIView = {
            let v = UIView(frame: .zero)
            v.backgroundColor = .brown
            
            return v
        }()
        
        header.textLabel?.textAlignment = .center
        header.textLabel?.textColor = .systemBlue
        header.backgroundView = view
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("kilo1 cellforRow : \(indexPath.section) , \(indexPath.row)")

        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewReuseIdentifier, for: indexPath) as! NTTableViewCell
        cell.setValueToCell(str: filteredList[indexPath.section].items1[indexPath.row].name)

        // 필터된 string을 처리하려면 진짜 필터 된 filterList가 필요하다
        
        return cell
    }
}
