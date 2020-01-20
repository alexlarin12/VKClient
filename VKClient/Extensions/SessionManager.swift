//
//  SessionManager.swift
//  VKClient
//
//  Created by Alex Larin on 14.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import Alamofire
extension SessionManager{
    static let custom:SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }()
}
