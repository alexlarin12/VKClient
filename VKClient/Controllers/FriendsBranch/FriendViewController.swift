//
//  FriendViewController.swift
//  VKClient
//
//  Created by Alex Larin on 05.04.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class FriendViewController: UIViewController {
    var friendNameForTitle:String = ""
    var friendStatus:Int = 0
    var friendImageForCollection:String = ""
    var friendOwnerId:Int = 0
    var apiService = ApiService()
    let database = PhotosRepository()
    var token: NotificationToken?
    var photosResult: Results<PhotoRealm2>?
    
    @IBOutlet weak var FriendPhotoCV: UICollectionView!
    @IBOutlet weak var FriendAvatarImageView: CircleImageView!
    @IBOutlet weak var FriendNameLabel: UILabel!
    @IBOutlet weak var FriendDataInLabel: UILabel!
    let customRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registCells()
        showHeader()
        self.FriendPhotoCV.dataSource = self
        self.FriendPhotoCV.delegate = self
        setupRefreshControl()
        showPhotos()
        getPhotoFromApi()
    
    }
    func registCells(){
        FriendPhotoCV.register(UINib(nibName: "FriendOnePhotoCell", bundle: nil), forCellWithReuseIdentifier: "FriendPhoto")
    }
    // метод отображения Header:
    fileprivate func showHeader(){
        showFriendStatus(friendStatus: friendStatus)
        title = friendNameForTitle
        self.FriendNameLabel.text = friendNameForTitle
        let urlAvatar = URL(string: friendImageForCollection)
        self.FriendAvatarImageView.kf.setImage(with: urlAvatar)
    }
    // метод отобаражения статуса друга:
    fileprivate func showFriendStatus(friendStatus: Int){
       if friendStatus == 1{
           self.FriendDataInLabel.text = "Online"
           self.FriendDataInLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
       } else {
           self.FriendDataInLabel.text = "Offline"
       }
    }
    // метод полечения фото друга:
    func getPhotoFromApi() {
         apiService.loadPhotosData(token: Session.instance.token, ownerId: friendOwnerId)
                   .done { photos in
                       self.database.savePhotosData(ownerId: self.friendOwnerId , photos: photos)
               }.catch {(error) in
                    print("Мы получили ошибку на странице фото: \(error)")
               }
    }
    // метод создания RefreshControl:
    fileprivate func setupRefreshControl(){
        customRefreshControl.attributedTitle = NSAttributedString(string: "wait...")
        customRefreshControl.tintColor = .red
        FriendPhotoCV.addSubview(customRefreshControl)
        customRefreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
    }
    @objc func update(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.customRefreshControl.endRefreshing()
        }
    }
}
