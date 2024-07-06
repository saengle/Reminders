//
//  AddEditTableViewCell.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

class AddEditTableViewCell: UITableViewCell {
    
    let textField = {
        let tf = UITextField()
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureHierachy() {
            [textField].forEach{contentView.addSubview($0)}
    }
    private func configureLayout() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    func configureCell(placeholer: String) {
        textField.placeholder = placeholer
    }
}
