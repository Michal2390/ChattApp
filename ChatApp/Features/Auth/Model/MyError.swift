//
//  MyError.swift
//  ChatApp
//
//  Created by Michal Fereniec on 26/09/2022.
//

import Foundation

enum MyError: Error {
    case invalidPassword
    case notFound
    case unexpected
}

extension MyError {
    var isFatal: Bool {
        if case MyError.unexpected = self { return true }
        else { return false }
    }
}

extension MyError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidPassword:
            return "The provided password is not valid."
        case .notFound:
            return "The specified item could not be found."
        case .unexpected:
            return "An unexpected error occurred."
        }
    }
}
