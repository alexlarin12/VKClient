//
//  FriendCollectionViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

private let reuseIdentifier = "Cell"

class FriendCollectionViewController: UICollectionViewController {
    var friendNameForTitle:String = ""
    var friendImageForCollection:String = ""
    var friendOwnerId:Int = 0
    var apiService = ApiService()
    let database = PhotosRepository()
    
    var token: NotificationToken?
    var photosResult: Results<PhotosRealm>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friendNameForTitle
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
     //   database.getPhotosData(ownerId: friendOwnerId)
        showPhotos()
        apiService.loadPhotosData(token: Session.instance.token, ownerId: friendOwnerId){ result in
            switch result{
            case .success(let photos):
                self.database.savePhotosData(ownerId: self.friendOwnerId , photos: photos)
            case .failure(let error):
                print(error)
            }
        }
    }
     func showPhotos(){
            do{
                photosResult = try database.getPhotosData(ownerId: friendOwnerId)
                token = photosResult?.observe { [weak self] results in
                    switch results{
                    case .error(let error):
                        print(error)
                    case .initial:
                        self?.collectionView.reloadData()
                    case let .update(_, deletions, insertions, modifications):
                        self?.collectionView.performBatchUpdates({
                            self?.collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                            self?.collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0) }))
                            self?.collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                        }, completion: nil)
                    }
                }
            }catch{
                print(error)
            }
        }
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosResult?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendIdentifire", for: indexPath) as? FriendCollectionCell,
            let photos = photosResult?[indexPath.row] else {
                return UICollectionViewCell()
        }
        let photo = photos.url
        let urlPhoto = URL(string: photo)
       // let dataPhoto = try? Data(contentsOf: urlPhoto)
        cell.LikeCountLabel.text = "\(photos.countLikes)"
      //  cell.FriendImageView.image = UIImage(data: dataPhoto!)
        cell.FriendImageView.kf.setImage(with: urlPhoto)
    
        return cell
    }
}
