//
//  MainCollectionViewCell.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureHierachy() {}
    private func configureLayout() {}
}
