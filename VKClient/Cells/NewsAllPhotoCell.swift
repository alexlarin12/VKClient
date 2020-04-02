//
//  NewsAllPhotoCell.swift
//  VKClient
//
//  Created by Alex Larin on 22.03.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import Kingfisher


class NewsAllPhotoCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
        
        var photosToShow: [Photos] = []
    
        @IBOutlet weak var photosInNews: UICollectionView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.photosInNews.dataSource = self
            self.photosInNews.delegate = self
            self.photosInNews.register(UINib.init(nibName: "NewsOnePhotoCell", bundle: nil), forCellWithReuseIdentifier: "NewsOnePhotoIdentifire")
        }
    }

    // MARK: Расширение для кастомизации фотографий
extension NewsAllPhotoCell {
        
        /// Количество фоток
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return photosToShow.count
        }
        
        /// Заполнение
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsOnePhotoIdentifire", for: indexPath as IndexPath) as? NewsOnePhotoCell
                else { return UICollectionViewCell() }
            
            /// Берем нужные размеры фото и кешируем с помощью Kingfisher
            if let url = URL(string: photosToShow[indexPath.row].sizes.first(where: {
                $0.type.rawValue == "x" || $0.type.rawValue == "y" || $0.type.rawValue == "z"  })?.url ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg") {
                photoCell.newsOnePhoto.kf.setImage(with: url)
            }
           
            return photoCell
        }
}


