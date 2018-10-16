//
//  BaseService.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 07/02/17.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation
import Moya
import T21Mapping
import T21HTTPRequester

public class BaseService <ResponseType> : TargetType, TargetTypeMapping {

    public var baseURL: URL { return URL(string: "http://t21services.herokuapp.com")! }

    public var path: String {
        return ""
    }

    public var method: Moya.Method {
        return .get
    }

    public var headers: [String: String]? {
        return nil
    }

    public var parameters: [String: Any]? {
        return nil
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    public var sampleData: Data {
        return "Sample data".utf8Encoded
    }

    public var task: Task {
        return .requestPlain

    }

    public var mapping: Mapping<HTTPRequesterResult<Moya.Response, MoyaError>, ResponseType> {
        //BaseService mapping is not valid, overwrite it.
        return Mapping({ _ in return ("" as! ResponseType) })
    }
}
