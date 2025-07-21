//
//  ViewModel.swift
//  MovieApp
//
//  Created by 김이든 on 7/17/25.
//

import Foundation
import UIKit

enum LoginError: LocalizedError {
    case emptyFields
    case usernameTaken
    case passwordMismatch
    case invalidUsername
    case invalidPassword
    case usernameContainsSpace
    case passwordContainsSpace
    case invalidCredentials
    case unexpected

    var errorDescription: String? {
        switch self {
        case .emptyFields:
            return "⚠︎ Please fill in all fields"
        case .usernameTaken:
            return "⚠︎ This username is already taken"
        case .passwordMismatch:
            return "⚠︎ Passwords do not match"
        case .invalidUsername:
            return "⚠︎ Username must be between 3 and 15 characters long"
        case .invalidPassword:
            return "⚠︎ Password must be between 8 and 16 characters long"
        case .usernameContainsSpace:
            return "⚠︎ Username cannot contain spaces"
        case .passwordContainsSpace:
            return "⚠︎ Password cannot contain spaces"
        case .invalidCredentials:
            return "⚠︎ Invalid username or password"
        case .unexpected:
            return "⚠︎ Unexpected error"
        }
    }
}

final class LoginViewModel {
    
    private let repository = UserAccountRepository()
    
    // 회원가입
    func saveUserAccount(username: String?, password: String?, passwordConfirmation: String?) throws {
        try validateUserInput(username: username, password: password, passwordConfirmation: passwordConfirmation)

        guard let username = username, let password = password else {
            throw LoginError.unexpected
        }

        repository.saveAccount(username: username, password: password)
    }
    
    func validateUserInput(username: String?, password: String?, passwordConfirmation: String?) throws {
        guard let username = username, !username.isEmpty,
              let password = password, !password.isEmpty,
              let passwordConfirmation = passwordConfirmation, !passwordConfirmation.isEmpty else {
            throw LoginError.emptyFields
        }

        if repository.isUsernameTaken(username) {
            throw LoginError.usernameTaken
        }
        
        guard password == passwordConfirmation else {
            throw LoginError.passwordMismatch
        }
        
        guard (3...15).contains(username.count) else {
            throw LoginError.invalidUsername
        }
        
        guard (8...16).contains(password.count) else {
            throw LoginError.invalidPassword
        }
        
        guard !username.contains(" ") else {
            throw LoginError.usernameContainsSpace
        }
        
        guard !password.contains(" ") else {
            throw LoginError.passwordContainsSpace
        }
    }
    
    // 로그인
    func login(username: String?, password: String?) throws {
        guard let username = username, !username.isEmpty,
              let password = password, !password.isEmpty else {
            throw LoginError.emptyFields
        }
        
        guard repository.validateUser(username: username, password: password) else {
            throw LoginError.invalidCredentials
        }
        
        repository.setCurrentUser(username: username)
    }
    
    // 계정이름 불러오기
    
    func getUsername() -> String? {
        return repository.getCurrentUser()
    }
    
    // 로그아웃
    func logout() {
        repository.clearCurrentUser()
    }
    
    
}

final class BookingViewModel {
    static let shared = BookingViewModel()
    private init() {}

    private var bookings: [MovieBooking] = []

    var numberOfRows: Int {
        return bookings.count
    }

    func booking(at index: Int) -> MovieBooking {
        return bookings[index]
    }

    func addBooking(movie: Movie, date: String, time: String, completion: @escaping () -> Void) {
        let booking = MovieBooking(movieTitle: movie.title, date: date, time: time, imageURL: movie.posterURL)
        bookings.append(booking)
        completion()
    }
}
