//
//  NewsVC+UITableViewDataSource.swift
//  VKClient
//
//  Created by Alex Larin on 14.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import Foundation
import UIKit
extension NewsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        guard let cell = NewsTableView.dequeueReusableCell(withIdentifier: "NewsIdentifire") as? NewsTableViewCell else{
            return UITableViewCell()
        }
        
        let newsIndex = news[indexPath.row]
        let newsImage = newsIndex.attachments?.first?.photo?.sizes.last?.url ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg"
        let urlNewsImage = URL(string: newsImage)!
        let dataNewsImage = try? Data(contentsOf: urlNewsImage)
        let comments = String(news[indexPath.row].comments.count)
        let reposts = String(news[indexPath.row].reposts.count)
        let views = String(news[indexPath.row].views.count)
 
        cell.NewsCountLabel.text = "\(newsIndex.likes.count)"
        cell.NewsTextView.text = newsIndex.text
        cell.NewsImageView.image = UIImage(data: dataNewsImage!)
        cell.NewsComments.setTitle(comments, for: .normal)
        cell.NewsReposts.setTitle(reposts, for: .normal)
        cell.NewsViews.setTitle(views, for: .normal)
        
        return cell
    }
  
    
}
