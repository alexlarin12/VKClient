//
//  NewsViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift

class NewsViewController: UIViewController {
    var apiService = ApiService()
    var news = [News]()
    var database = NewsRepository()
    var newsResult: Results<NewsRealm>?
    var token: NotificationToken?
    
    
    
    @IBOutlet weak var NewsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsIdentifire")
        self.NewsTableView.rowHeight = 350
        self.NewsTableView.dataSource = self
        //self.getNewsFromDatabase()
           apiService.loadNewsData(token: Session.instance.token, userId: Session.instance.userId)
           { result in
                        switch result{
                        case .success(let news):
                          //  self.database.saveNewsData(news: news)
                            self.news = news
                            self.NewsTableView.reloadData()
                        case .failure(let error):
                            print(error)
                        }
           }
       
    }
    private func getNewsFromDatabase() {
             do {
                 self.newsResult = try database.getNewsData()
                 self.NewsTableView.reloadData()
             } catch {
              print(error)
              
          }
      }
    
    
     func showNews(){
        do{
           newsResult = try database.getNewsData()
           token = newsResult?.observe { [weak self] results in
                switch results{
                case .error(let error):
                    print(error)
                case .initial:
                    self?.NewsTableView.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    self?.NewsTableView.beginUpdates()
                    self?.NewsTableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.NewsTableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.NewsTableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.NewsTableView.endUpdates()
                }
           }
                   
           }catch{
              print(error)
           }
       }
    
    
    
    
}
