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
    let mainVerticalStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4.0
        return sv
    }()
    let horizontalStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8.0
        return sv
    }()
    let priorityLabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.textColor = .systemPurple
        return lb
    }()
    let titleLabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
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
        lb.font = .systemFont(ofSize: 17)
        lb.textColor = .systemGray
        lb.numberOfLines = 7
        return lb
    }()
    let secondHorizontalStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8.0
        return sv
    }()
    let dateLabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 17)
        lb.textColor = .systemGray
        lb.numberOfLines = 1
        return lb
    }()
    let tagLabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 17)
        lb.textColor = .systemTeal
        lb.numberOfLines = 1
        return lb
    }()
    let myImageView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ListTableViewCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        [checkButton, mainVerticalStackView].forEach{contentView.addSubview($0)}
        [horizontalStackView, contentLabel, secondHorizontalStackView, myImageView].forEach{mainVerticalStackView.addArrangedSubview($0)}
        [priorityLabel, titleLabel, flagImageView].forEach{horizontalStackView.addArrangedSubview($0)}
        [dateLabel, tagLabel].forEach{secondHorizontalStackView.addArrangedSubview($0)}
    }
    private func configureLayout(width: CGFloat) {
        checkButton.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView)
            make.width.height.equalTo(30)
        }
        mainVerticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing)
            make.top.bottom.trailing.equalToSuperview()
        }
        flagImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView)
            make.width.equalTo(flagImageView.snp.height)
        }
        myImageView.snp.makeConstraints{ make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(((width - 62) / 2))
        }
    }
    func configureCell(title: String, flag: Bool, content: String?, priority: String?, date: String?, tag: String?, image: UIImage?, width: CGFloat) {
        configureHierachy()
        configureLayout(width: width)
        checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.tintColor = .systemGray
        
        mainVerticalStackView.alignment = .leading
        mainVerticalStackView.isLayoutMarginsRelativeArrangement = true
        
        horizontalStackView.alignment = .leading
        priorityLabel.text = priority
        titleLabel.text = title
        flagImageView.isHidden = !flag
        
        contentLabel.text = content
       
        dateLabel.text = date
        tagLabel.text = tag
        myImageView.image = image
    }
}
//circle.inset.filled  + color => 눌렀을 때 그 계열 색
//circle : 기본색. 아직 처리 못한 투두
//circle.dotted : 빈 칸
