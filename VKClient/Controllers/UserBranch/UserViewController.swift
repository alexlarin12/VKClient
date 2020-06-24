//
//  UserViewController.swift
//  VKClient
//
//  Created by Alex Larin on 01.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift
import AsyncDisplayKit

class UserViewController: ASViewController<ASDisplayNode> {
    var userRealm = [UserRealm]()
    var database = UserRepository()
    var photobase = PhotosRepository()
    let apiService = ApiService()
    var token: NotificationToken?
    var photosResult: Results<PhotoRealm2>?
    let dateTimeHelper = DateTimeHelper()
    var tableNode: ASTableNode{
        return node as! ASTableNode
    }
    init() {
        super.init(node: ASTableNode())
        tableNode.delegate = self
        tableNode.dataSource = self
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = #colorLiteral(red: 0.239143461, green: 0.437407434, blue: 0.7932939529, alpha: 1)
        getPhotoFromApi()
        showPhotos()
        self.userRealm = self.database.getUserData()
    }
      // метод полечения фото пользователя:
    func getPhotoFromApi() {
        apiService.loadPhotosData(token: Session.instance.token, ownerId: Session.instance.userId)
            .done { photos in
                self.photobase.savePhotosData(ownerId: Session.instance.userId , photos: photos)}
            .catch {(error) in
                print("Мы получили ошибку на странице фото: \(error)")
            }
    }
    func showPhotos(){
        do{
            photosResult = try photobase.getPhotosData(ownerId: Session.instance.userId)
           
        }catch{
            print(error)
        }
    }
}
extension UserViewController: ASTableDataSource{
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return photosResult?.count ?? 0
    }
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
     
        let photoUser = photosResult?[indexPath.row]
        let height = photoUser?.sizes.last?.height ?? 0
        let width = photoUser?.sizes.last?.width ?? 1
        var aspectRatio: CGFloat { return CGFloat(height)/CGFloat(width) }
        let urlImage = photoUser?.sizes.last?.url
        let block = { () -> ASCellNode in
            let node = UserCell(aspectRatio: aspectRatio, urlImage: urlImage ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg")
            return node
        }
        return block
    }
 
}
extension UserViewController: ASTableDelegate{
    
}
