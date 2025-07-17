//
//  LoginViewController.swift
//  MovieApp
//
//  Created by 김이든 on 7/16/25.
//

import UIKit
import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "loginLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    private let introLabel = UILabel().then {
        $0.text = "Book Smarter. Watch Better."
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.numberOfLines = 1
    }
    
    private let errorLabel = UILabel().then {
        $0.text = "⚠︎ Incorrect username or password."
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 1
        $0.alpha = 0
    }
    
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
    
    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.tintColor = .white
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.backgroundColor = Colors.point
    }
    
    private let signupButton = UIButton(type: .system).then {
        let fullText = "Don't have an account? Sign Up"
        let boldText = "Sign Up"
        
        // 전체 기본 스타일
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.white
            ]
        )
        
        // Sign up 부분만 Bold
        if let boldRange = fullText.range(of: boldText) {
            let nsRange = NSRange(boldRange, in: fullText)
            attributedString.addAttributes([
                .font: UIFont.systemFont(ofSize: 14, weight: .bold),
                .foregroundColor: UIColor.systemBlue
            ], range: nsRange)
        }
        
        // UIButton에 Attributed Title 적용
        $0.setAttributedTitle(attributedString, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.primary
        
        [imageView, introLabel, errorLabel, usernameTextField, passwordTextField, loginButton, signupButton].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(imageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-view.frame.height * 0.25)
        }
        
        introLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(6)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(introLabel.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(usernameTextField.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        signupButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func loginTapped() {
        print("Login Tapped")
    }
    
    @objc private func signupTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
