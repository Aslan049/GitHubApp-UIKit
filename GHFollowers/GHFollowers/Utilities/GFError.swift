//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Aslan Korkmaz on 2.07.2025.
//

import Foundation

enum GFError: String, Error {
    case invalidUserName = "This username created an invalid request."
    case unableToComplete = "Unable to complete your request."
    case invalidResponse = "Invalid response from the serves."
    case invalidData = "The data received from the server was invalid."
    
    
}
