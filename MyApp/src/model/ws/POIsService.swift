//
//  POIsService.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 07/02/17.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation
import Moya
import T21Mapping
import T21HTTPRequester

/**
 * Get the list of existing POIs.
 */
class GetPOIsRequestDTO: BaseService<GetPOIsResponseDTO> {
    override var path: String {
        return "/points"
    }

    override var mapping: Mapping<HTTPRequesterResult<Moya.Response, MoyaError>, GetPOIsResponseDTO> {
        return Mapping({ (result) in
            do {
                let response: ResponseDTO<ListDTO<POIDTO>> = try ResponseDTO(result: result)
                return GetPOIsResponseDTO.success(dto: response)
            } catch let error as ResponseError {
                return GetPOIsResponseDTO.error(error: error)
            } catch {
                return GetPOIsResponseDTO.mappingFailed
            }
        })
    }
}

public enum GetPOIsResponseDTO {
    case success(dto: ResponseDTO<ListDTO<POIDTO>>) // HTTP Status code: 200
    case mappingFailed
    case error(error: Swift.Error)
}

/**
 * Get an specific POI detail.
 */
class GetPOIRequestDTO: BaseService<GetPOIResponseDTO> {

    let POIIdentifier: POIIdentifier

    init( _ POIIdentifier: POIIdentifier) {
        self.POIIdentifier = POIIdentifier
    }

    override var baseURL: URL {
        return URL(string: "http://t21services.herokuapp.com/points/" + POIIdentifier)!
    }

    override var mapping: Mapping<HTTPRequesterResult<Moya.Response, MoyaError>, GetPOIResponseDTO> {
        return Mapping({ (result) in
            do {
                let response: ResponseDTO<POIDTO> = try ResponseDTO(result: result)
                return GetPOIResponseDTO.success(dto: response)
            } catch let error as ResponseError {
                return GetPOIResponseDTO.error(error: error)
            } catch {
                return GetPOIResponseDTO.mappingFailed
            }
        })
    }
}

public enum GetPOIResponseDTO {
    case success(dto: ResponseDTO<POIDTO>) // HTTP Status code: 200
    case mappingFailed
    case error(error: Swift.Error)
}
