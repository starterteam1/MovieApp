//
//  SignupViewController.swift
//  MovieApp
//
//  Created by 김이든 on 7/16/25.
//

import UIKit
import SnapKit
import Then

final class SignupViewController: UIViewController {
    
    private let usernameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
                string: "Username",
                attributes: [.foregroundColor: UIColor.lightGray]
            )
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.placeholderBorder.cgColor
        $0.backgroundColor = Colors.placeholderBackground
        $0.layer.cornerRadius = 12
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        $0.leftViewMode = .always
        $0.clipsToBounds = true
    }
    
    private let passwordTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
                string: "Password",
                attributes: [.foregroundColor: UIColor.lightGray]
            )
        $0.layer.borderWidth = 1
        $0.layer.borderColor =  Colors.placeholderBorder.cgColor
        $0.backgroundColor = Colors.placeholderBackground
        $0.layer.cornerRadius = 12
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        $0.leftViewMode = .always
        $0.clipsToBounds = true
    }
    
    private let confirmTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
                string: "Confirm Password",
                attributes: [.foregroundColor: UIColor.lightGray]
            )
        $0.layer.borderWidth = 1
        $0.layer.borderColor =  Colors.placeholderBorder.cgColor
        $0.backgroundColor = Colors.placeholderBackground
        $0.layer.cornerRadius = 12
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        $0.leftViewMode = .always
        $0.clipsToBounds = true
    }
    
    private let signupButton = UIButton(type: .system).then {
        $0.setTitle("Sign Up", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.tintColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.backgroundColor = Colors.point
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.primary
        
        title = "Sign Up"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        [usernameTextField, passwordTextField, confirmTextField, signupButton].forEach {
            view.addSubview($0)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(64)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(usernameTextField.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        confirmTextField.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        signupButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(confirmTextField.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
    }
    
}
