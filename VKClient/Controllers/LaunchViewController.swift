//
//  LaunchViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit
import WebKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var VKWebView: WKWebView!{
        didSet{
            VKWebView.navigationDelegate = self
        }
    }
    
    @IBAction func UnwindSegue(unwindSegue:UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path =  "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7281894"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value:"wall,friends,photos,groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.105")
        ]
        let request = URLRequest(url: urlComponents.url!)
        VKWebView.load(request)
    }

}
