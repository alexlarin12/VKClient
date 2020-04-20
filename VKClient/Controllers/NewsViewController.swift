//
//  NewsViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher
import AVFoundation

/*
protocol NewsTableUpdater: class {
    func updateTable()
}



class NewsViewController: UIViewController {
    var apiService = ApiService()
    var news = [ResponseItem]()
    var groups = [Groups]()
    var videos = [Video]()
    var profiles = [Profiles]()
    var database = NewsRepository()
    var database2 = UserRepository()
    var userRealm = [UserRealm]()
    var newsResult: Results<NewsRealm>?
    var token: NotificationToken?
    var cellsToDisplay: [NewsCellsTypes] = [.header, .text, .attachments, .footer]
    
    
    
    @IBOutlet weak var NewsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsTableView.register(UINib(nibName: "NewsTextTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTextIdentifire")
        NewsTableView.register(UINib(nibName: "NewsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsHeaderIdentifier")
        NewsTableView.register(UINib(nibName: "NewsFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFooterIdentifire")
        NewsTableView.register(UINib(nibName: "NewsAllPhotoCell", bundle: nil), forCellReuseIdentifier: "NewsAllPhotoIdentifire")
        NewsTableView.register(UINib(nibName: "NewsVideoCell", bundle: nil), forCellReuseIdentifier: "NewsVideo")
        NewsTableView.register(UINib(nibName: "NewsLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsLink")
        NewsTableView.register(UINib(nibName: "NewsEmptyCell", bundle: nil), forCellReuseIdentifier: "NewsEmpty")
        NewsTableView.register(UINib(nibName: "WhatsNewTableViewCell", bundle: nil), forCellReuseIdentifier: "WhatsNews")        //  self.NewsTableView.rowHeight = 200
        
        self.NewsTableView.dataSource = self

        //self.getNewsFromDatabase()
        apiService.loadNewsData(token: Session.instance.token, userId: Session.instance.userId){[weak self] result in
   //         self?.news = news
    //        print(news)
  //      }
         // { result in
                       switch result{
                        case .success(let news):
                            self?.groups = news.groups
                            self?.news = news.items
                            self?.profiles = news.profiles
                         //   self?.database.saveNewsData(news: news.items)
                            self?.NewsTableView.reloadData()
                        case .failure(let error):
                            print(error)
                        }
           }
         apiService.loadUserData(token: Session.instance.token, userId: Session.instance.userId) { [weak self] user in
                   self?.database2.saveUserData(user: user)
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
}*/
