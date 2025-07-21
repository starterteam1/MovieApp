//
//  BookingsCell.swift
//  MovieApp
//
//  Created by 김이든 on 7/16/25.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class BookingsCell: UITableViewCell {
    
    private let viewModel = TestViewModel()
    
    static let id = "BookingsCell"
    
    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    private let movieLabel = UILabel().then {
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 1
    }
    
    private let informationLabel = UILabel().then {
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 1
    }
    
    private lazy var textStackView = UIStackView(arrangedSubviews: [movieLabel, informationLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fill
        movieLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        informationLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
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
            textStackView
        ].forEach { contentView.addSubview($0)}
        
        movieImageView.snp.makeConstraints {
            $0.size.equalTo(contentView.snp.height).multipliedBy(0.7)
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        textStackView.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    public func setupCell(with booking: MovieBooking) {
        if let url = booking.imageURL {
            movieImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "film"))
        } else {
            movieImageView.image = UIImage(systemName: "film")
        }
        movieLabel.text = booking.movieTitle
        informationLabel.text = "\(booking.date)"
    }
    
}
