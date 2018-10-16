//
//  Environment.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 20/01/17.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation
import RNCryptor
import T21EnvironmentSwift

public class EnvironmentProvider {

    private static let privateInstance = EnvironmentProvider()

    private var environment: T21Environment

    public class func sharedInstance() -> T21Environment {
        return privateInstance.environment
    }

    private init() {
        //decrypt the saved environments.bin to get environments.json contents
        let environmentsFilePath = Bundle.main.path(forResource: "environments", ofType: "bin")
        if let path = environmentsFilePath {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let decryptor = RNCryptor.DecryptorV3(password: "mFzM4yqADV")
                let jsonData = try decryptor.decrypt(data: data)
                let j = try JSONSerialization.jsonObject(with: jsonData, options: [])
                if let json = j as? [String: Any] {
                    Logger.debug("environments.json contents: \(json.description)")
                    environment = T21Environment(json)
                } else {
                    Logger.error("environments.bin malformed JSON.")
                    environment = T21Environment([String: Any]())
                }
            } catch {
                Logger.error("environments.bin file can't be loaded.")
                environment = T21Environment([String: Any]())
            }
        } else {
            Logger.error("environments.bin file not found.")
            environment = T21Environment([String: Any]())
        }
    }
}

extension String {
    public func localized() -> String {
        return EnvironmentProvider.sharedInstance().localizedString(self)
    }
}
