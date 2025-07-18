//
//  UserAccountRepository.swift
//  MovieApp
//
//  Created by 김이든 on 7/17/25.
//
import Foundation

final class UserAccountRepository {
    private let accountsKey = "accounts"

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
