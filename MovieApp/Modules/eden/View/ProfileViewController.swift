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
    
    private let loginViewModel = LoginViewModel()
    private let viewModel = TestViewModel()
    
//    private let logoutButton = UIButton().then {
//        var config = UIButton.Configuration.filled()
//        config.title = "Logout"
//        config.baseBackgroundColor = .red
//        config.baseForegroundColor = .white
//        config.cornerStyle = .medium
//        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
//        
//        $0.configuration = config
//    }
    
    private var profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "person.circle")
        $0.tintColor = .white
        $0.layer.masksToBounds = true
    }
    
    private var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .bold)
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .red
        
        [/*logoutButton, */profileImageView, nameLabel, bookingsLabel, bookingsTableView].forEach {
            view.addSubview($0)
        }
        nameLabel.text = loginViewModel.getUsername() ?? "User Name"
        
//        logoutButton.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
//        }
        
        profileImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(profileImageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-view.frame.height * 0.25)
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
        
//        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
    }
    
    @objc private func logoutTapped() {
        loginViewModel.logout()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            let loginVC = LoginViewController()
            let navController = UINavigationController(rootViewController: loginVC)
            
            window.rootViewController = navController
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionFlipFromRight,
                              animations: nil,
                              completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookingsTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookingViewModel.shared.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookingsCell.id, for: indexPath) as? BookingsCell else {
            return UITableViewCell()
        }
        let booking = BookingViewModel.shared.booking(at: indexPath.row)
        cell.setupCell(with: booking)
        return cell
    }
}
