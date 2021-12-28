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
            return "Ha ocurrido un error. Inténtelo de nuevo mas tarde"
        case .invalidResponse:
            return "Respuesta inválida"
        case .invalidEndpoint:
            return "Endpoint inválido"
        case .noData:
            return "No hay datos"
        case .serializationError:
            return "Error de serialización"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
