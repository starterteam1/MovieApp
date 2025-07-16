//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by 김이든 on 7/16/25.
//

import UIKit
import SnapKit
import Then

final class ProfileViewController: UIViewController {
    
    private var profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "person.circle")
        $0.tintColor = .white
        $0.layer.cornerRadius = 80
        $0.clipsToBounds = true
    }
    
    private var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .bold)
        $0.text = "User Name"
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let bookingsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.text = "My Bookings"
        $0.textColor = .white
    }
    
    private lazy var bookingsTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(BookingsCell.self, forCellReuseIdentifier: BookingsCell.id)
        $0.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.primary
        
        title = "Profile"
        
        [profileImageView, nameLabel, bookingsLabel, bookingsTableView].forEach {
            view.addSubview($0)
        }
        
        profileImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(profileImageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.4)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            
        }
        
        bookingsLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(64)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        bookingsTableView.snp.makeConstraints {
            $0.top.equalTo(bookingsLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookingsCell.id) as? BookingsCell else {
            return UITableViewCell() }
        return cell
    }
    
    
}
