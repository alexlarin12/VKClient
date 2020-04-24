//
//  NewsVC+UITableViewDataSource.swift
//  VKClient
//
//  Created by Alex Larin on 14.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import AVFoundation

/*
extension NewsViewController: UITableViewDataSource, UITableViewDelegate{
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if news.count == 0 {
      return 1 + news.count
        }else {
            return news.count
        }
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
    return 1
        } else {
       return 4
        }
    }
   func attachmentRowHeight(indexPath: IndexPath) -> CGFloat {
          let linkAttachment = news[indexPath.section].links
          let photosAttachment = news[indexPath.section].photos
          let videoAttachment = news[indexPath.section].videos
          /// Если внутри аттача есть вложения "photo"
          if photosAttachment != nil {
              if photosAttachment?.count == 1 {
                  return 220
              }
              else if photosAttachment?.count == 2 {
                  return 200
              }
              else if photosAttachment?.count == 3 {
                  return 150
              }
              else {
                  return 350
              }
              
          /// Если любое другое вложение
          } else if videoAttachment != nil {
             return 150
          } else if linkAttachment != nil {
             if linkAttachment?.count == 1 {
                             return 220
                         }
                         else if linkAttachment?.count == 2 {
                             return 200
                         }
                         else if linkAttachment?.count == 3 {
                             return 150
                         }
                         else {
                return 350
                
            }
                
            } else {
              return 0
           }
         
      }
   
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                                   let sectionNumber = indexPath.section
                                   let rowHeightOfCurrentSection = cellsToDisplay[indexPath.row]
                                   
                                   switch sectionNumber {
                                   case 0:
                                       return 60
                                   default:
                                       
                                       switch rowHeightOfCurrentSection {
                                       case .header:
                                           return 65
                                       case .repostHeader:
                                           return 60
                                       case .text:
                                           return UITableView.automaticDimension
                                       case .attachments:
                                           return attachmentRowHeight(indexPath: indexPath)
                                       case .footer:
                                           return 40
                                       }
                                   
                               }
    }
   
    func textCellCreation(indexPath:   IndexPath,
                          tableView:   UITableView,
                          position:    Int) -> UITableViewCell {
        
        guard let text = tableView.dequeueReusableCell(withIdentifier: "NewsTextIdentifire", for: indexPath) as? NewsTextTableViewCell else { return UITableViewCell() }
     //   text.NewsTextView.text = news[position].text
        text.NewsTextLabel.text = news[position].text
           return text
    }
    
    func headerCellCreation(indexPath:   IndexPath,
                            tableView:   UITableView,
                            position:    Int,
                            sourceId:    Int) -> UITableViewCell {
           
        guard let header = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderIdentifier", for: indexPath) as? NewsHeaderTableViewCell else { return UITableViewCell() }
        
        header.NewsHeaderDataLabel.text = DateTimeHelper.getFormattedDate(from: Date(timeIntervalSince1970: TimeInterval(news[position].date)))
        
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
   
    func attCellCreation(indexPath:   IndexPath,
                           tableView:   UITableView,
                           position:    Int) -> UITableViewCell {
        if news[position].videos != nil {
            let newsVideo = news[indexPath.section].videos
            guard let video = tableView.dequeueReusableCell(withIdentifier: "NewsVideo", for: indexPath) as? NewsVideoCell else { return UITableViewCell() }
            let url = URL(string: newsVideo?.first?.image?.first(where: {$0.height.rawValue == 240 || $0.height.rawValue == 320 || $0.height.rawValue == 450})?.url ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg")
           
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
            let urlLink = news[position].links
            let url = URL(string: urlLink?.first?.photo?.sizes.first(where: {$0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"})?.url ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg")
                /*
            $0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"  })?.url ??   */         link.LinkImageView.kf.setImage(with: url)
            return link
        } else {
            guard  let empty = tableView.dequeueReusableCell(withIdentifier: "NewsEmpty", for: indexPath) as? NewsEmptyCell else { return UITableViewCell()}
    
           return empty
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
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
 
                   /// Наполняем ячейки новостей отдельными методами
        switch cellsToDisplay[indexPath.row] {
        case .header:
            return headerCellCreation(  indexPath:  indexPath,
                                        tableView:  tableView,
                                        position:   itemNumber,
                                        sourceId:   sourceId)
        case .repostHeader:
            return headerCellCreation(  indexPath:  indexPath,
                                        tableView:  tableView,
                                        position:   itemNumber,
                                        sourceId:   sourceId)
        case .text:
            return textCellCreation(    indexPath:  indexPath,
                                        tableView:  tableView,
                                        position:   itemNumber)
        case .attachments:
            return attCellCreation(     indexPath:  indexPath,
                                        tableView:  tableView,
                                        position:   itemNumber)
        case .footer:
            return footerCellCreation(  indexPath:  indexPath,
                                        tableView:  tableView,
                                        position:   itemNumber)
            
            }
        }
    }
    
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                 guard let cellText = NewsTableView.dequeueReusableCell(withIdentifier: "NewsIdentifire") as? NewsTableViewCell
                    else{
                     return UITableViewCell()
                     }

                 let newsIndex = news[indexPath.row]
                 let newsImage = newsIndex.photos.first?.sizes.last?.url ??  "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg"
                 let urlNewsImage = URL(string: newsImage)
                 let dataNewsImage = try? Data(contentsOf: urlNewsImage!)
                 let comments = String(news[indexPath.row].comments!.count)
                 let reposts = String(news[indexPath.row].reposts!.count)
                 let views = String(news[indexPath.row].views!.count)
                  cellText.NewsCountLabel.text = "\(newsIndex.likes?.count ?? 0)"
                  cellText.NewsTextView.text = newsIndex.text
                  cellText.NewsImageView.image = UIImage(data: dataNewsImage!)
                  cellText.NewsComments.setTitle(comments, for: .normal)
                  cellText.NewsReposts.setTitle(reposts, for: .normal)
                  cellText.NewsViews.setTitle(views, for: .normal)
             
            return cellText
    }
    */
    
}
/*
extension NewsViewController: NewsTableUpdater {
    func updateTable() {
        NewsTableView.reloadData()
    }
}*/
*/
