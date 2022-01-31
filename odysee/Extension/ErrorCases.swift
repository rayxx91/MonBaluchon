//
//  ErrorCases.swift
//  odysee
//
//  Created by chaleroux on 07/12/2021.
//

import Foundation

// all cases of errors
enum ErrorCases: Swift.Error {
    case noData
    case wrongResponse(Swift.Error?)
    case failure
    case errorDecode(Swift.Error)
}
