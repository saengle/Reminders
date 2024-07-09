//
//  MainCollectionViewCell.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    private let mainVStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        return sv
    }()
    let listImageView = {
        let iv =  UIImageView()
        return iv
    }()
    let listTitleLabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 17)
        lb.textColor = .systemGray
        return lb
    }()
    private let hStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .leading
        return sv
    }()
    let numberOfListItemLabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 30)
        lb.textAlignment = .right
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureHierachy() {
        contentView.addSubview(mainVStackView)
        mainVStackView.addSubview(hStackView)
        mainVStackView.addSubview(listTitleLabel)
        hStackView.addArrangedSubview(listImageView)
        hStackView.addArrangedSubview(numberOfListItemLabel)
    }
    private func configureLayout() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        mainVStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(8)
        }
        hStackView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.contentView.snp.height).multipliedBy(0.5)
        }
        listImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(listImageView.snp.height)
        }
        numberOfListItemLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(listImageView)
            make.trailing.equalTo(contentView).inset(16)
        }
        listTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(listImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    func configureCell(color: UIColor, image: UIImage, title: String, number: Int?) {
        listImageView.tintColor = color
        listImageView.image = image
        listTitleLabel.text = title
        numberOfListItemLabel.text = "\(number ?? 0)"
    }
}
