//
//  TestViewModel.swift
//  MovieApp
//
//  Created by 김이든 on 7/17/25.
//

import Foundation

final class TestViewModel {
    
    private let tableViewArray: [String] = Array(1...50).map { String($0) }
    
    var numberOfRows: Int {
        return tableViewArray.count
    }
    
    func makeDataSource(index: Int) -> String {
        return tableViewArray[index]
    }
    
}
