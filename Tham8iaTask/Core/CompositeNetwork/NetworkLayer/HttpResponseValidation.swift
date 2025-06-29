//
//  HttpResponseValidation.swift
//  NetworkLayer
//
//  Created by Khaled Kamal on 11/09/2023.
//

import Foundation

public typealias Response = (data: Data, response: URLResponse)

protocol HttpResponseValidation {
    func validate(output: Response) throws -> Response
}

class HttpResponseValidator: HttpResponseValidation {
    var isDebug: Bool = true

    static func `default`() -> HttpResponseValidation {
        return HttpResponseValidator()
    }

    func validate(output: Response) throws -> Response {
        guard let response = output.response as? HTTPURLResponse,
              let status = response.status
        else {
            throw URLError(.unsupportedURL)
        }

        if isDebug {
            let serialize = try? JSONSerialization.jsonObject(with: output.data)
            print("=====>>>> debug date", serialize ?? String(data: output.data, encoding: .utf8) ?? "")
            print("=====>>>> debug Status Code:", response.statusCode)
        }

        switch status.responseType {
        case .success:
            return output

        case .clientError:
            return output

        default:
            throw "Error with status code: \(response.statusCode)"
        }
    }
}
