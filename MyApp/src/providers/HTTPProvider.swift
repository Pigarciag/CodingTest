//
//  HTTPProvider.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 09/02/17.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation
import Moya
import T21HTTPRequester

protocol HTTPProvider {
    func request<RequestType>( _ service: RequestType,
                 _ completion: @escaping (_ response: RequestType.T) -> Void ) where RequestType: TargetType,
    RequestType: TargetTypeMapping
    func requestSimple( _ service: TargetType,
                        _ completion: @escaping (_ response: HTTPRequesterResult<Moya.Response, MoyaError>) -> Void)
}

public class HTTPProviderImp: HTTPProvider {

    //private static let sharedInstance = HTTPProvider()
    private let innerRequester: HTTPRequester

    public init() {

        //configure a custom MoyaProvider
        // https://github.com/Moya/Moya/blob/master/docs/Endpoints.md
        let endpointClosure = { (target: MultiTarget) -> Endpoint<MultiTarget> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return defaultEndpoint.adding(newHTTPHeaderFields: ["APP_NAME": "TODO: APP NAME"])
        }

        //add the logger plugin
        let loggingPlugin = HTTPRequesterLoggerPlugin(verbose: false)

        //create the innerRequester using a MoyaProvider
        let moyaProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, plugins: [loggingPlugin])
        self.innerRequester = HTTPRequester(moyaProvider)
    }

    public func request<RequestType>( _ service: RequestType,
                        _ completion: @escaping (_ response: RequestType.T) -> Void )
        where RequestType: TargetType, RequestType: TargetTypeMapping {
            self.innerRequester.request(service, completion)
    }

    public func requestSimple( _ service: TargetType,
                               _ completion: @escaping (_ response: HTTPRequesterResult<Moya.Response, MoyaError>) -> Void) {
        self.innerRequester.requestSimple(service, completion)
    }

}
