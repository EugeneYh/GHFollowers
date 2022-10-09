//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 08.10.2022.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case badConnection = "Unable to your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "Invalid data. Please try again"
}
