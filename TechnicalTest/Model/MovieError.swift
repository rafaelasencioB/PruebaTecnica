//
//  MovieError.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import Foundation

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidResponse
    case invalidEndpoint
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError:
            return ""
        case .invalidResponse:
            return ""
        case .invalidEndpoint:
            return ""
        case .noData:
            return ""
        case .serializationError:
            return ""
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
