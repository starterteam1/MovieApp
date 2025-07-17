//
//  BookingsCell.swift
//  MovieApp
//
//  Created by 김이든 on 7/16/25.
//

import UIKit
import SnapKit
import Then

final class BookingsCell: UITableViewCell {
    
    private let viewModel = TestViewModel()
    
    static let id = "BookingsCell"
    
    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    private let movieLabel = UILabel().then { _ in }
    
    private let informationLabel = UILabel().then { _ in }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = Colors.primary
        
        [   movieImageView,
            movieLabel,
            informationLabel
        ].forEach { contentView.addSubview($0)}
        
        movieImageView.snp.makeConstraints {
            $0.size.equalTo(contentView.snp.height).multipliedBy(0.7)
            $0.leading.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }
        
        movieLabel.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        
        informationLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview()
        }
    }
    
    public func setupCell(string: String) {
        movieImageView.image = UIImage(systemName: "film")
        movieLabel.text = string
        informationLabel.text = "Information"
    }
    
}
