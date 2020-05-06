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
    
    @IBOutlet weak var FriendPhotoCV: UICollectionView!/*{
        didSet {
            self.FriendPhotoCV.dataSource = self
            self.FriendPhotoCV.delegate = self
        }
    }*/
    @IBOutlet weak var FriendAvatarImageView: CircleImageView!
    @IBOutlet weak var FriendNameLabel: UILabel!
    @IBOutlet weak var FriendDataInLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if friendStatus == 1{
            self.FriendDataInLabel.text = "Online"
            self.FriendDataInLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            self.FriendDataInLabel.text = "Offline"
        }
        title = friendNameForTitle
        self.FriendNameLabel.text = friendNameForTitle
        let urlAvatar = URL(string: friendImageForCollection)
        self.FriendAvatarImageView.kf.setImage(with: urlAvatar)
        
        FriendPhotoCV.register(UINib(nibName: "FriendOnePhotoCell", bundle: nil), forCellWithReuseIdentifier: "FriendPhoto")
        self.FriendPhotoCV.dataSource = self
        self.FriendPhotoCV.delegate = self
        refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
        FriendPhotoCV.addSubview(refreshControl)
        
        showPhotos()
        apiService.loadPhotosData(token: Session.instance.token, ownerId: friendOwnerId)
            .done { photos in
                self.database.savePhotosData(ownerId: self.friendOwnerId , photos: photos)
        }.catch {(error) in
             print("Мы получили ошибку на странице фото: \(error)")
        }
        
        
      /*  self.FriendPhotoCV.dataSource = self
        self.FriendPhotoCV.delegate = self*/
       
    }
    @objc func update(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.refreshControl.endRefreshing()
        }
    }
}
