//
//  AlertOption.swift
//  ClockApp
//
//  Created by BS-272 on 15/2/21.
//

import Foundation
struct AlertOption {
    let id = UUID()
    var type: AlertType = .none
    var message: String = ""
}
enum AlertType: String {
    case success = "Success"
    case error = "Error"
    case none = ""
}
