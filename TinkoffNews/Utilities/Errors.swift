//
//  Errors.swift
//  TinkoffNews
//
//  Created by jufina on 23.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation

enum ErrorType: Error {
    case network(description: String)
    case common
    
    func message() -> String {
        switch self {
        case .common:
            return "Общая ошибка"
        case .network(let description):
            return description
        }
    }
}
