//
//  ListTableViewCell.swift
//  Reminders
//
//  Created by 쌩 on 7/4/24.
//

import UIKit

import SnapKit

class ListTableViewCell: UITableViewCell {
    let checkButton = UIButton()
    let horizontalStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        
    }()
    let priorityLabel = UILabel()
    let titleLabel = {
        let lb = UILabel()
//        lb.font = .systemFont(ofSize: 17)
        return lb
    }()
    let flagImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "flag.fill")
        iv.tintColor = .systemOrange
        return iv
    }()
    let contentLabel = {
        let lb = UILabel()
//        lb.font = .systemFont(ofSize: 17)
        lb.numberOfLines = 7
        return lb
    }()
    let dateLabel = UILabel()
    let tagLabel = UILabel()
    let myImageView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ListTableViewCell.id)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        [checkButton, titleLabel].forEach{contentView.addSubview($0)}
//        [].forEach{horizontalStackView.addSubview($0)}
    }
    private func configureLayout() {
        checkButton.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
            make.width.height.equalTo(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing)
            make.top.equalToSuperview()
        }
    }
    func configureCell() {
        titleLabel.text = "data.title"
        checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.tintColor = .systemGray
        configureHierachy()
        configureLayout()
    }
}
//circle.inset.filled  + color => 눌렀을 때 그 계열 색
//circle : 기본색. 아직 처리 못한 투두
//circle.dotted : 빈 칸
