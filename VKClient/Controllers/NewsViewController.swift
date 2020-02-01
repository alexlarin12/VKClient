//
//  NewsViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    var apiService = ApiService()

    @IBOutlet weak var NewsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsIdentifire")
        self.NewsTableView.rowHeight = 350
        self.NewsTableView.dataSource = self
       
    }
}
