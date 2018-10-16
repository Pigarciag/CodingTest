//
//  ResponseDTO.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 02/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import Foundation
import Moya
import Marshal
import Result

public enum ResponseError: Swift.Error {
    case connection(error: MoyaError)
    case statusCode(statusCode: Int)
}

/**
 * @throws: ResponseError.statusCode, ResponseError.connection, MarshalError and OutputType(object: MarshaledObject) exceptions.
 */
public class ResponseDTO<OutputType: Unmarshaling> {

    let response: OutputType

    public required init(result: Result<Moya.Response, Moya.MoyaError>) throws {
        switch result {
        case let .success(httpResponse):
            switch httpResponse.statusCode {
            case 200:
                let jsonObject = try JSONParser.JSONObjectWithData(httpResponse.data)
                response = try OutputType(object: jsonObject)
            default:
                throw ResponseError.statusCode(statusCode: httpResponse.statusCode)
            }

        case let .failure(error):
            throw ResponseError.connection(error: error)
        }
    }
}
