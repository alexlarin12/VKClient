//
//  NewsTableViewController.swift
//  VKClient
//
//  Created by Alex Larin on 05.04.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import Kingfisher

enum NewsCellsTypes {
    case header, repostHeader, text, attachments, footer
}

class NewsTableViewController: UITableViewController {
    var apiService = ApiService()
    
    var news = [ResponseItem]()
    var groups = [ItemsGroup]()
    var videos = [Video]()
    var profiles = [ItemsFriend]()
    var nextFrom = ""
    var isFetchingMoreNews = false
    var database = NewsRepository()
    var database2 = UserRepository()
    var userRealm = [UserRealm]()
    var cellsToDisplay: [NewsCellsTypes] = [.header, .repostHeader, .text, .attachments, .footer]
    let newsLinkCell = NewsLinkTableViewCell()
    let dateTimeHelper = DateTimeHelper()
    let customRefreshControl = UIRefreshControl()
    var startTime: Double?
    private var expandedCells = Set<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.tableView.register(UINib(nibName: "NewsTextTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTextIdentifire")
            self.tableView.register(UINib(nibName: "NewsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsHeaderIdentifier")
            self.tableView.register(UINib(nibName: "RepostHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "RepostHeaderIdentifire")
            self.tableView.register(UINib(nibName: "NewsFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFooterIdentifire")
            self.tableView.register(UINib(nibName: "NewsAllPhotoCell", bundle: nil), forCellReuseIdentifier: "NewsAllPhotoIdentifire")
            self.tableView.register(UINib(nibName: "NewsVideoCell", bundle: nil), forCellReuseIdentifier: "NewsVideo")
            self.tableView.register(UINib(nibName: "NewsLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsLink")
            self.tableView.register(UINib(nibName: "NewsEmptyCell", bundle: nil), forCellReuseIdentifier: "NewsEmpty")
            self.tableView.register(UINib(nibName: "WhatsNewTableViewCell", bundle: nil), forCellReuseIdentifier: "WhatsNews")
        
            tableView.prefetchDataSource = self
        
            getNewsFromApi(startFrom: nextFrom, startTime: 0)
            getUserFromApi()
            setupRefreshControl()
    
    }
    
    //метод загрузки новостей:
    fileprivate func getNewsFromApi(startFrom: String, startTime: Int) {
        isFetchingMoreNews = true
        let nextFrom = startFrom
        self.apiService.loadNewsData(token: Session.instance.token, userId: Session.instance.userId, nextFrom: nextFrom, startTime: 0){[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let news):
                DispatchQueue.main.async {
                    self.news.append(contentsOf: news.items)
                    self.groups.append(contentsOf: news.groups)
                    self.profiles.append(contentsOf: news.profiles)
                    self.nextFrom = news.nextFrom ?? ""
                self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            self.isFetchingMoreNews = false
            
        }
    }
    //метод загрузки данных о пользователе:
    func getUserFromApi() {
         self.apiService.loadUserData(token: Session.instance.token, userId: Session.instance.userId) { [weak self] user in
            self?.database2.saveUserData(user: user)
            }
    }
 
    // MARK: - Table view data source
    // определение колличества секций:
    override func numberOfSections(in tableView: UITableView) -> Int {
        if news.count == 0 {
            return 1 + news.count
        }else {
            return  news.count
              }
    }
    // определение колличества ячеек:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
          return 1
        } else {
            return cellsToDisplay.count
        }
    }
    //расчет размеров ячеек Link, Photo, Video:
    func attachmentRowHeight(indexPath: IndexPath ) -> CGFloat {
        let linkAttachment = news[indexPath.section].links
        let photosAttachment = news[indexPath.section].photos
        let videoAttachment = news[indexPath.section].videos
       
        if photosAttachment != nil {
            if photosAttachment?.count == 1 {
               let widthScreen = tableView.frame.width
               if let widthRaw = news[indexPath.section].photos?.first?.sizes.first(where: {$0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"})?.width,
                let hightRaw = news[indexPath.section].photos?.first?.sizes.first(where: {$0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"})?.height{
                let hightPhoto = CGFloat(hightRaw)
                let widthPhoto = CGFloat(widthRaw)
                
                let hight = CGFloat((hightPhoto / widthPhoto) * (widthScreen - 32))
                return hight
               }else {
                print("photosAttachment - unknown format")
                return 0
                
                }
            }
            else if photosAttachment?.count == 2 {
                return 200
            }
            else if photosAttachment?.count == 3 {
                return 150
            }
            else {
                return 300
            }
            
        } else if videoAttachment != nil {
            let widthScreen = tableView.frame.width
            
            let heightRaw = news[indexPath.section].videos?.first?.image?.first(where: {$0.height.rawValue == 240 || $0.height.rawValue == 320 || $0.height.rawValue == 450})?.height
            switch heightRaw {
            case .h240:
                let widthRaw = news[indexPath.section].videos?.first?.image?.first(where: {$0.height.rawValue == 240})?.width
                let widthPhoto = CGFloat(widthRaw ?? 240)
                let height = CGFloat((CGFloat(240) / widthPhoto) * (widthScreen + 32))
                return height
            case .h320:
                let widthRaw = news[indexPath.section].videos?.first?.image?.first(where: {$0.height.rawValue == 320})?.width
                let widthPhoto = CGFloat(widthRaw ?? 320)
                let height = CGFloat((CGFloat(320) / widthPhoto) * (widthScreen - 32))
                return height
            case .h450:
                let widthRaw = news[indexPath.section].videos?.first?.image?.first(where: {$0.height.rawValue == 450})?.width
                let widthPhoto = CGFloat(widthRaw ?? 450)
                let height = CGFloat((CGFloat(450) / widthPhoto) * (widthScreen - 32))
                return height
            default:
                return 250
            }
            
        } else if linkAttachment != nil {
            let widthScreen = tableView.frame.width
            let widthRaw = news[indexPath.section].links?.first?.photo?.sizes.first?/*(where: {$0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"})?*/.width
            let hightRaw = news[indexPath.section].links?.first?.photo?.sizes.first?/*(where: {$0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"})?*/.height
            let hightPhoto = CGFloat(hightRaw ?? 320)
            let widthPhoto = CGFloat(widthRaw ?? 320)
            let textLabel = news[indexPath.section].links?.first?.title
            if textLabel == nil{
                let hight = CGFloat((hightPhoto / widthPhoto) * (widthScreen - 32))
                return hight} else {
                let height = CGFloat((hightPhoto / widthPhoto) * (widthScreen - 32) + 100)
                return height
            }
      
        } else {
            return 2
        }
       
    }
   

    //установка высот всех ячеек:
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionNumber = indexPath.section
        let rowHeightOfCurrentSection = cellsToDisplay[indexPath.row]
                                        
        switch sectionNumber {
        case 0:
            return 50
        default:
                                            
            switch rowHeightOfCurrentSection {
            case .header:
                return 65
            case .repostHeader:
                if news[indexPath.section].copyHistory != nil {
                    return 60
                } else {
                    return 0
                }
            case .text:
               
                
                if news[indexPath.section].text == "" && (news[indexPath.section].copyHistory?.first?.text ?? "") == "" {
                    
                    return 0
                }else {
                    return UITableView.automaticDimension
                }
            case .attachments:
                return attachmentRowHeight(indexPath: indexPath)
            case .footer:
                return 40
            }
        }
    }
    
    //функция создания ячейки text:
    func textCellCreation(indexPath:   IndexPath,
                           tableView:   UITableView,
                           position:    Int) -> UITableViewCell {
        if news[indexPath.section].copyHistory != nil{
            guard let text = tableView.dequeueReusableCell(withIdentifier: "NewsTextIdentifire", for: indexPath) as? NewsTextTableViewCell/*,news[indexPath.section].copyHistory?.first?.text != ""*/ else { return UITableViewCell() }
            text.NewsTextView.text = news[position].copyHistory?.first?.text
                return text
            
        }else {
         guard let text = tableView.dequeueReusableCell(withIdentifier: "NewsTextIdentifire", for: indexPath) as? NewsTextTableViewCell,news[indexPath.section].text != "" else { return UITableViewCell() }
            var shortText: String {
                return String((news[position].text?.prefix(200))!)
            }
            var activeText: String {
                expandedCells.contains(indexPath) ? news[position].text ?? "" : shortText
            }
            text.indexPath = indexPath
            text.delegate = self
            if expandedCells.contains(indexPath) {
                text.ShowMore.setTitle("...show less", for: .normal)
            } else {
                text.ShowMore.setTitle("...show more", for: .normal)
            }
            text.NewsTextView.text = activeText
            text.newsTextHeight.constant = text.getRowHeightFromText(text: activeText)
            text.configur()
            return text
            
        }
    }
    
    //функция создания ячейки header:
    func headerCellCreation(indexPath:   IndexPath,
                             tableView:   UITableView,
                             position:    Int,
                             sourceId:    Int) -> UITableViewCell {
            
        guard let header = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderIdentifier", for: indexPath) as? NewsHeaderTableViewCell else { return UITableViewCell() }
         
        header.NewsHeaderDataLabel.text = dateTimeHelper.getFormattedDate(indexPath: indexPath, from: Date(timeIntervalSince1970: TimeInterval(news[position].date)))
         
        for account in profiles {
            if sourceId == account.id * -1 || sourceId == account.id {
                header.NewsHeaderLabel.text = account.firstName + " " + account.lastName
                if let url = URL(string: account.photo50) {
                header.NewsHeaderAvatar.kf.setImage(with: url)
                }
            }
        }
         
        for group in groups {
            if sourceId == group.id * -1 || sourceId == group.id {
                header.NewsHeaderLabel.text = group.name
                if let url = URL(string: group.photo50) {
                     // let data = try? Data(contentsOf: url)
                     // header.NewsHeaderAvatar.image = UIImage(data: data!)
                header.NewsHeaderAvatar.kf.setImage(with: url)
                }
            }
        }
        return header
    }
    
    //функция создания ячейки repostHeader:
    func repostHeaderCellCreation(indexPath:   IndexPath,
                             tableView:   UITableView,
                             position:    Int,
                             fromId:    Int) -> UITableViewCell {
            
        guard let header = tableView.dequeueReusableCell(withIdentifier: "RepostHeaderIdentifire", for: indexPath) as? RepostHeaderTableViewCell else { return UITableViewCell() }
         
        header.RepostDataLabel.text = dateTimeHelper.getFormattedDate(indexPath: indexPath, from: Date(timeIntervalSince1970: TimeInterval(news[position].copyHistory?.first?.date ?? 0)))
      
             for account in profiles {
                if fromId == account.id * -1 || fromId == account.id {
                    let repostNameTitle = account.firstName + " " + account.lastName
                    header.RepostNameButton.setTitle(repostNameTitle, for: .normal)
                if let url = URL(string: account.photo50) {
                 header.RepostAvatarImageView.kf.setImage(with: url)
                }
             }
         }
         
          for group in groups {
                if fromId == group.id * -1 || fromId == group.id {
                    let repostNameTitle = group.name
                    header.RepostNameButton.setTitle(repostNameTitle, for: .normal)
                if let url = URL(string: group.photo50) {
                 header.RepostAvatarImageView.kf.setImage(with: url)
                 }
             }
         }
         return header
    }
    
    //функция создания ячейки footer:
    func footerCellCreation(indexPath:  IndexPath,
                                        tableView:  UITableView,
                                        position:   Int) -> UITableViewCell {
            
        guard let footer = tableView.dequeueReusableCell(withIdentifier: "NewsFooterIdentifire", for: indexPath) as? NewsFooterTableViewCell else { return UITableViewCell() }
       
        if news[indexPath.section].likes?.userLikes == 1 {
            footer.LikeNews.isLiked = true
        } else {
            footer.LikeNews.isLiked = false
        }
            
        footer.LikeCountNews.text = ("\(news[position].likes?.count ?? 0)")
        let comments = "\(news[position].comments?.count ?? 0)"
        let reposts = "\(news[position].reposts?.count ?? 0)"
        footer.CommentsCountNews.setTitle(comments, for: .normal)
        footer.RepostsCountNews.setTitle(reposts, for: .normal)
            
        if let viewsCounter = news[position].views?.count {
            if viewsCounter < 1000 {
                footer.EyeCountNews.setTitle("\(viewsCounter)", for: .normal)
            } else {
                footer.EyeCountNews.setTitle("\(viewsCounter / 1000) k", for: .normal)
            }
        }
        return footer
    }
    //функция создания ячейки attachment:
    func attCellCreation(indexPath:   IndexPath,
                         tableView:   UITableView,
                        position:    Int) -> UITableViewCell {
        if news[position].videos != nil {
            let newsVideo = news[indexPath.section].videos
            guard let video = tableView.dequeueReusableCell(withIdentifier: "NewsVideo", for: indexPath) as? NewsVideoCell else { return UITableViewCell() }
            let url = URL(string: newsVideo?.first?.image?.first(where: {$0.height.rawValue == 240 || $0.height.rawValue == 320 || $0.height.rawValue == 450})?.url ??
                "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg")
            video.VideoImage.kf.setImage(with: url)
             
            return video
        }
        if news[position].photos != nil {
             
            guard let photo = tableView.dequeueReusableCell(withIdentifier: "NewsAllPhotoIdentifire", for: indexPath) as? NewsAllPhotoCell else { return UITableViewCell() }
                photo.photosToShow = news[position].photos ?? []
                photo.photosInNews.reloadData()
                return photo
        }
        if news[position].links != nil {
            guard let link = tableView.dequeueReusableCell(withIdentifier: "NewsLink", for: indexPath) as? NewsLinkTableViewCell else { return UITableViewCell() }
            let urlLink = news[indexPath.section].links
                
            let url = URL(string: urlLink?.first?.photo?.sizes.first?/*(where: {$0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"})?*/.url ??
                    "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg")
            
            if let linkTitle = urlLink?.first?.button?.title{
                link.LinkTitleButton.backgroundColor = UIColor.gray
                link.LinkTitleButton.setTitle(linkTitle, for: .normal)
                
            }
                link.LinkImageView.kf.setImage(with: url)
                link.TextLinkLabel.text = urlLink?.first?.title
                return link
        } else {
            guard  let empty = tableView.dequeueReusableCell(withIdentifier: "NewsEmpty", for: indexPath) as? NewsEmptyCell else { return UITableViewCell()}
     
        return empty
             
        }
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
    //создание и наполнение ячейки WhatsNews:
            let whatsNew = tableView.dequeueReusableCell(withIdentifier: "WhatsNews") as? WhatsNewTableViewCell
            userRealm = database2.getUserData()
            userRealm.forEach { user in
                let avatar = user.photo50
                let urlAvatar = URL(string: avatar)
                whatsNew?.UserAvatar.kf.setImage(with: urlAvatar)}
            return whatsNew ?? UITableViewCell()
        } else {
                        
            let itemNumber = indexPath.section
            let sourceId = news[itemNumber].sourceID
            let fromId = news[itemNumber].copyHistory?.first?.fromID ?? 0
      
    // Наполняем ячейки новостей отдельными методами
             
        switch cellsToDisplay[indexPath.row] {
            case .header:
                return headerCellCreation (  indexPath:  indexPath,
                                             tableView:  tableView,
                                             position:   itemNumber,
                                             sourceId:   sourceId)
            case .repostHeader:
                return repostHeaderCellCreation (  indexPath:  indexPath,
                                             tableView:  tableView,
                                             position:   itemNumber,
                                             fromId:   fromId)
            case .text:
                return textCellCreation (    indexPath:  indexPath,
                                             tableView:  tableView,
                                             position:   itemNumber)
            case .attachments:
                return attCellCreation (     indexPath:  indexPath,
                                             tableView:  tableView,
                                             position:   itemNumber)
            case .footer:
                return footerCellCreation (  indexPath:  indexPath,
                                             tableView:  tableView,
                                             position:   itemNumber)
                 
                 }
             }
    }
    // паттерн Pull-To-Refresh (обновление новостей):
    fileprivate func setupRefreshControl(){
        
        customRefreshControl.attributedTitle = NSAttributedString(string: "wait...")
        customRefreshControl.tintColor = .red
        customRefreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        tableView.refreshControl = customRefreshControl
        
    }
    
    @objc func refreshNews(){
     
        let existDate = Date().timeIntervalSince1970
        startTime = news.first?.date ?? existDate
        
        self.apiService.loadNewsData(token: Session.instance.token, userId: Session.instance.userId, nextFrom: "", startTime:(startTime! + 1)) {[weak self] result in
                guard let self = self else {return}
                self.customRefreshControl.endRefreshing()
                switch result{
                    case .success(let news):
                        DispatchQueue.main.async {
                            guard news.items.count > 0 else { return }
                            self.news = news.items + self.news
                            self.groups = news.groups + self.groups
                            self.profiles = news.profiles + self.profiles
                            self.startTime = news.items.first?.date ?? existDate
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                              print(error)
                }
        }
    }
    //реализация паттерна Infinity Scrolling:
    func prefetchRowsAt(indexPaths: [IndexPath]) {
        guard !isFetchingMoreNews,
        let maxSection = indexPaths.map({ $0.section }).max(),
        news.count <= maxSection + 3 else { return }
        getNewsFromApi(startFrom: nextFrom, startTime: 0)
    }
}

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        self.prefetchRowsAt(indexPaths: indexPaths)
    }
}
extension NewsTableViewController: NewsTextCellDelegate{
    func onShowMoreTaped(indexPath: IndexPath) {
        if expandedCells.contains(indexPath){
            print("remove")
            expandedCells.remove(indexPath)
        }else{
            expandedCells.insert(indexPath)
            print("insert")
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}
