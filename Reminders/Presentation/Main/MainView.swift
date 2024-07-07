//
//  MainView.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

import SnapKit

class MainView: UIView {
    
    let searchBar = {
        let sb = UISearchBar()
        sb.barTintColor = .secondarySystemBackground
        sb.placeholder = "Search"
        sb.showsCancelButton = false
        sb.searchBarStyle = .minimal
        return sb
    }()
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    private let flowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.itemSize = .init(width: (width - 32 - 16) / 2, height: 92)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        mainCollectionView.backgroundColor = .systemBackground
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        [searchBar, mainCollectionView].forEach{self.addSubview($0)}
    }
    private func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    func configureView() {}
}
