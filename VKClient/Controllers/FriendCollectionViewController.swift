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
    var vkService = VKService()
    var photos = [ItemsPhotos]()
    var saveRealmData = SaveRealmData()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friendNameForTitle
        print("owner_id = \(friendOwnerId)")
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        vkService.loadPhotosData(ownerId:friendOwnerId){result in
            switch result{
            case .success(let photos):
                self.photos = photos
                self.collectionView.reloadData()
                self.saveRealmData.savePhotosData(photos: photos)
            case .failure(let error):
                print(error)
            }
            
            
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendIdentifire", for: indexPath) as! FriendCollectionCell
        let photo = photos[indexPath.row].url
        let urlPhoto = URL(string: photo)!
        let dataPhoto = try? Data(contentsOf: urlPhoto)
       
            cell.LikeCountLabel.text = "\(photos[indexPath.row].countLikes)"
            cell.FriendImageView.image = UIImage(data: dataPhoto!)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
