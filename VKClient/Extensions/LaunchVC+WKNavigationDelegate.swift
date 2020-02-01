//
//  LaunchVC+WKNavigationDelegate.swift
//  VKClient
//
//  Created by Alex Larin on 14.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import SwiftKeychainWrapper
extension LaunchViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
      
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map {$0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
                
        }
        
        let token = params["access_token"]
        KeychainWrapper.standard.set(token ?? "", forKey: "token")
        let userId = params["user_id"]
        KeychainWrapper.standard.set(Int(userId ?? "") ?? 0, forKey: "id")
        print(token ?? "token is empty")
        print(userId ?? "")
        session.token = token ?? ""
        session.userId = Int(userId ?? "") ?? 0
        let tokenFromKeychain = KeychainWrapper.standard.string(forKey: "token")
        print(tokenFromKeychain ?? "")
        
        performSegue(withIdentifier: "FromLaunchToFriends", sender: tokenFromKeychain)
         decisionHandler(.cancel)
        
    }
    
}
