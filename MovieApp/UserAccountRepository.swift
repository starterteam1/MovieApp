//
//  UserAccountRepository.swift
//  MovieApp
//
//  Created by 김이든 on 7/17/25.
//
import Foundation

final class UserAccountRepository {
    private let accountsKey = "accounts"
    private let currentUserKey = "currentUser"

    func fetchAccounts() -> [[String: String]] {
        return UserDefaults.standard.array(forKey: accountsKey) as? [[String: String]] ?? []
    }

    func saveAccount(username: String, password: String) {
        var accounts = fetchAccounts()
        let newAccount = ["username": username, "password": password]
        accounts.append(newAccount)
        UserDefaults.standard.set(accounts, forKey: accountsKey)
    }

    func isUsernameTaken(_ username: String) -> Bool {
        return fetchAccounts().contains(where: { $0["username"] == username })
    }

    func validateUser(username: String, password: String) -> Bool {
        return fetchAccounts().contains(where: { $0["username"] == username && $0["password"] == password })
    }
}

//현재 로그인 아이디 저장
extension UserAccountRepository {
    
    // 현재 로그인 사용자 저장
    func setCurrentUser(username: String) {
        UserDefaults.standard.set(username, forKey: currentUserKey)
    }

    // 현재 로그인 사용자 불러오기
    func getCurrentUser() -> String? {
        return UserDefaults.standard.string(forKey: currentUserKey)
    }

    // 로그아웃 시 사용자 제거
    func clearCurrentUser() {
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
}
