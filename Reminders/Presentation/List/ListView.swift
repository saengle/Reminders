//
//  ListView.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

class ListView: UIView {
    
    let titleLabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 24)
        return lb
    }()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        configureHierachy()
        configureLayout()
        configureView(title: "전체")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        self.addSubview(titleLabel)
        self.addSubview(tableView)
    }
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    func configureView(title: String) {
        titleLabel.text = title
    }
}
