//
//  FriendCollectionViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
class FriendCollectionViewController: UICollectionViewController {
    var friendNameForTitle:String = ""
    var friendImageForCollection:String = ""
    var friendOwnerId:Int = 0
    var apiService = ApiService()
    var photosRealm = [PhotosRealm]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friendNameForTitle
        print("owner_id = \(friendOwnerId)")
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        print(friendOwnerId)
        apiService.loadPhotosData(ownerId: friendOwnerId){[weak self] photosRealm in
            self?.photosRealm = photosRealm
            self?.collectionView.reloadData()
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosRealm.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendIdentifire", for: indexPath) as! FriendCollectionCell
        let photo = photosRealm[indexPath.row].url
        let urlPhoto = URL(string: photo)!
        let dataPhoto = try? Data(contentsOf: urlPhoto)
            cell.LikeCountLabel.text = "\(photosRealm[indexPath.row].countLikes)"
            cell.FriendImageView.image = UIImage(data: dataPhoto!)
        return cell
    }
}
