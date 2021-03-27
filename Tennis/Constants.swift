//
//  Constants.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import Foundation
import Foundation
enum AuthState: String {
    case success = "Success"
    case error = "Error"
    case authenticating = "Authenticating"
    case initial = "Initial"
}

enum ViewState: String {
    case loading = "Loading"
    case success = "Success"
    case initial = "Initial"
    case error = "Error"
}
