//
//  AddEditView.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

class AddEditView: UIView {
    
    let tableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .secondarySystemBackground
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemBackground
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        tableView.register(AddEditTableViewCell.self, forCellReuseIdentifier: AddEditTableViewCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
