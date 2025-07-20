//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by 이돈혁 on 7/16/25.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    private let movie: Movie
    private let directorLabel = UILabel()

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#121417")
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#121417")
        
        title = "Detail"

        let scrollView = UIScrollView()
        let contentView = UIView()

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        if let url = movie.posterURL {
            imageView.kf.setImage(with: url)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = movie.title
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white

        let overviewLabel = UILabel()
        overviewLabel.text = movie.overview
        overviewLabel.font = .systemFont(ofSize: 16)
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0

        let directorTitle = UILabel()
        directorTitle.text = "Release Date"
        directorTitle.font = .boldSystemFont(ofSize: 20)
        directorTitle.textColor = .white

        directorLabel.text = movie.releaseDate ?? "출시일 정보 없음"
        directorLabel.font = .systemFont(ofSize: 16)
        directorLabel.textColor = .white

        let ratingTitle = UILabel()
        ratingTitle.text = "Ratings"
        ratingTitle.font = .boldSystemFont(ofSize: 20)
        ratingTitle.textColor = .white

        let scoreLabel = UILabel()
        if let rating = movie.rating {
            scoreLabel.text = String(format: "%.1f", rating)
        } else {
            scoreLabel.text = "N/A"
        }
        scoreLabel.font = .boldSystemFont(ofSize: 28)
        scoreLabel.textColor = .white

        let starsLabel = UILabel()
        if let rating = movie.rating {
            let fullStars = Int(rating / 2) // 10점 만점 → 5점 만점으로 변환
            let halfStar = rating.truncatingRemainder(dividingBy: 2) >= 1.0
            var stars = String(repeating: "★", count: fullStars)
            if halfStar {
                stars += "☆"
            }
            stars += String(repeating: "☆", count: 5 - stars.count)
            starsLabel.text = stars
        } else {
            starsLabel.text = "☆☆☆☆☆"
        }
        starsLabel.textColor = .white

        let reviewCountLabel = UILabel()
        reviewCountLabel.text = "125 reviews"
        reviewCountLabel.textColor = .white
        reviewCountLabel.font = .systemFont(ofSize: 14)

        let bookButton = UIButton()
        bookButton.setTitle("Book Tickets", for: .normal)
        bookButton.backgroundColor = UIColor(hex: "#7A1CAC")
        bookButton.setTitleColor(.white, for: .normal)
        bookButton.layer.cornerRadius = 12
        bookButton.titleLabel?.font = .boldSystemFont(ofSize: 16)

        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, overviewLabel, directorTitle, directorLabel, ratingTitle, scoreLabel, starsLabel, reviewCountLabel, bookButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.setCustomSpacing(30, after: reviewCountLabel)

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bookButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),
            bookButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
