
import UIKit
import SnapKit
import Then
import Kingfisher // For image downloading

class MoviePosterCell: UICollectionViewCell {
    
    static let identifier = "MoviePosterCell"
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .darkGray // Placeholder color
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.clear.cgColor
            layer.borderWidth = isSelected ? 3 : 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with movie: TMDBMovie) {
        titleLabel.text = movie.title
        if let posterPath = movie.posterPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil // Or a placeholder image
        }
    }
}
