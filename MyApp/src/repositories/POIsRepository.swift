//
//  POIsRepository.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 13/06/2017.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation

protocol POIsRepository {
    func requestGetPOIs(_ completion: @escaping ( _ response: GetPOIsResponseDTO) -> Void)
    func requestGetPOI( _ POIIdentifier: POIIdentifier, _ completion: @escaping ( _ response: GetPOIResponseDTO) -> Void)
}

class POIsRepositoryImp: POIsRepository {
    func requestGetPOIs(_ completion: @escaping (GetPOIsResponseDTO) -> Void) {
        let provider = SharedContainer().resolved(HTTPProvider.self)
        provider.request(GetPOIsRequestDTO(), { (response: GetPOIsResponseDTO) in
            completion(response)
        })
    }

    func requestGetPOI( _ POIIdentifier: POIIdentifier, _ completion: @escaping ( _ response: GetPOIResponseDTO) -> Void) {
        let provider = SharedContainer().resolved(HTTPProvider.self)
        provider.request(GetPOIRequestDTO(POIIdentifier), { (response: GetPOIResponseDTO) in
            completion(response)
        })
    }
}
