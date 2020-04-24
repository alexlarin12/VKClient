//
//  FriendVC+UICollectionViewDataSource.swift
//  VKClient
//
//  Created by Alex Larin on 06.04.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//


import UIKit
extension FriendViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosResult?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhoto", for: indexPath) as? FriendOnePhotoCell else {return UICollectionViewCell()}
        
        if let urlPhoto = URL(string: photosResult?[indexPath.row].sizes.first(where: {$0.type == "x" || $0.type == "y" || $0.type == "z"})?.url ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg"){
            cell.FriendPhotoImageView.kf.setImage(with: urlPhoto)
            
        }
        
        return cell
    }
   
    func showPhotos(){
               do{
                   photosResult = try database.getPhotosData(ownerId: friendOwnerId)
                   token = photosResult?.observe { [weak self] results in
                       switch results{
                       case .error(let error):
                           print(error)
                       case .initial:
                           self?.FriendPhotoCV.reloadData()
                       case let .update(_, deletions, insertions, modifications):
                           self?.FriendPhotoCV.performBatchUpdates({
                               self?.FriendPhotoCV.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                               self?.FriendPhotoCV.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0) }))
                               self?.FriendPhotoCV.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                           }, completion: nil)
                       }
                   }
               }catch{
                   print(error)
               }
    }
     
   
    
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WatchPhoto",
            
            let friendCollectionViewController = segue.destination as? FriendCollectionViewController,
            let indexPath = FriendPhotoCV.indexPath(for: FriendOnePhotoCell()) {
            /*
             let name = (getModelAtIndex(indexPath: indexPath)?.firstName ?? "") + " " + (getModelAtIndex(indexPath: indexPath)?.lastName ?? "")
             let image = getModelAtIndex(indexPath: indexPath)?.photo50
             let ownerId = getModelAtIndex(indexPath: indexPath)?.id
             friendViewController.friendNameForTitle = name
             friendViewController.friendImageForCollection = image ?? ""
             friendViewController.friendOwnerId = ownerId ?? 0*/
        }
    }*/
    
    
}
extension FriendViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
          performSegue(withIdentifier: "WatchPhoto", sender: Any?.self)
           
    
    }
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
     }
  
   
         /*   func getModelAtIndex(indexPath: IndexPath) -> PhotosRealm? {
        return sortedPhotosResults[indexPath.section].items[indexPath.row]
      }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "WatchPhoto",
       
        let friendCollectionViewController = segue.destination as? FriendCollectionViewController,
        let indexPath = FriendPhotoCV.indexPathsForSelectedItems{
            let index = indexPath[0]
            let numberValue = index[1]
            let imageId = photosResult?[numberValue].id
            friendCollectionViewController.friendNameForTitle = friendNameForTitle
            friendCollectionViewController.imageId = imageId ?? 0
            friendCollectionViewController.friendOwnerId = friendOwnerId
        }else {
            print(false)
        }
    }
}
