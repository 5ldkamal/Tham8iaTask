//
//  Model+ParameterConvertible.swift
//  Calorie
//
//  Created by Khaled Kamal on 09/12/2023.
//

import Foundation

protocol ParameterConvertible {
    func toBodyParameter() -> Parameters
}

// Extend the protocol to provide a default implementation
extension ParameterConvertible {
    func toBodyParameter() -> Parameters {
        var result: [String: Any] = [:]

        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let key = child.label {
                switch child.value {
                case is String:
                    result[key] = child.value as? String

                case is Int:
                    result[key] = "\((child.value as? Int))"

                default:
                    break
                }
            }
        }

        return result
    }
}
