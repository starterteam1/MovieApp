//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by 이돈혁 on 7/16/25.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class MoviesViewController: UIViewController {
    
    private var movies: [Movie] = []
    private var horizontalMovies: [Movie] = []
    
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nowPlayingButton = UIButton(type: .system)
    private let comingSoonButton = UIButton(type: .system)
    private let exclusiveButton = UIButton(type: .system)
    
    private let featuredLabel: UILabel = {
        let label = UILabel()
        label.text = "특집"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 250)
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 250)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // ⬅️ 이 줄 추가
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        fetchMovies()
    }
    
    private func fetchMovies() {
        MovieService.shared.fetchFeaturedMovies { [weak self] movies in
            self?.movies = movies
            self?.movieCollectionView.reloadData()
        }

        MovieService.shared.fetchUpcomingMovies { [weak self] movies in
            self?.horizontalMovies = movies
            self?.horizontalCollectionView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Movies"
        
        // Filter Buttons
        nowPlayingButton.setTitle("상영 중", for: .normal)
        comingSoonButton.setTitle("개봉 예정작", for: .normal)
        exclusiveButton.setTitle("독점상영", for: .normal)
        
        [nowPlayingButton, comingSoonButton, exclusiveButton].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor(red: 122/255, green: 28/255, blue: 172/255, alpha: 1.0)
            $0.layer.cornerRadius = 18
            $0.heightAnchor.constraint(equalToConstant: 42).isActive = true
            filterStackView.addArrangedSubview($0)
        }
        
        nowPlayingButton.addTarget(self, action: #selector(didTapNowPlaying), for: .touchUpInside)
        comingSoonButton.addTarget(self, action: #selector(didTapComingSoon), for: .touchUpInside)
        exclusiveButton.addTarget(self, action: #selector(didTapExclusive), for: .touchUpInside)
        
        view.addSubview(filterStackView)
        view.addSubview(horizontalCollectionView)
        view.addSubview(featuredLabel)
        view.addSubview(movieCollectionView)
        
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        featuredLabel.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false

        filterStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-32)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        horizontalCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }

        featuredLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalCollectionView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }

        movieCollectionView.snp.makeConstraints {
            $0.top.equalTo(featuredLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
    }
    
    private func updateButtonStyles(selectedButton: UIButton) {
        [nowPlayingButton, comingSoonButton, exclusiveButton].forEach {
            $0.backgroundColor = ($0 == selectedButton) ? UIColor(red: 122/255, green: 28/255, blue: 172/255, alpha: 1.0) : UIColor(red: 43/255, green: 48/255, blue: 54/255, alpha: 1.0)
        }
    }
    
    @objc private func didTapNowPlaying() {
        updateButtonStyles(selectedButton: nowPlayingButton)
        MovieService.shared.fetchNowPlayingMovies { [weak self] movies in
            self?.horizontalMovies = movies
            self?.horizontalCollectionView.reloadData()
        }
    }

    @objc private func didTapComingSoon() {
        updateButtonStyles(selectedButton: comingSoonButton)
        MovieService.shared.fetchUpcomingMovies { [weak self] movies in
            self?.horizontalMovies = movies
            self?.horizontalCollectionView.reloadData()
        }
    }

    @objc private func didTapExclusive() {
        updateButtonStyles(selectedButton: exclusiveButton)
        MovieService.shared.fetchExclusiveMovies { [weak self] movies in
            self?.horizontalMovies = movies
            self?.horizontalCollectionView.reloadData()
        }
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return horizontalMovies.count
        } else {
            return movies.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie: Movie
        if collectionView == horizontalCollectionView {
            movie = horizontalMovies[indexPath.item]
        } else {
            movie = movies[indexPath.item]
        }
        cell.titleLabel.text = movie.title
        cell.genreLabel.text = "Genre TBD"
        cell.posterImageView.kf.setImage(with: movie.posterURL)
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie
        if collectionView == horizontalCollectionView {
            movie = horizontalMovies[indexPath.item]
        } else {
            movie = movies[indexPath.item]
        }
        let detailVC = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

class MovieCell: UICollectionViewCell {
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let genreLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 18
        contentView.clipsToBounds = true

        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)

        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true

        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .white

        genreLabel.font = UIFont.systemFont(ofSize: 12)
        genreLabel.textColor = .lightGray

        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }

        genreLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
