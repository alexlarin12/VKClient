//
//  MainViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    var apiService = ApiService()
    var userRealm = [UserRealm]()
    var database = UserRepository()
    var displayDataOperation = DisplayDataOperation()
    @IBOutlet weak var MainNameLabel: UILabel!
    @IBOutlet weak var MainIdLabel: UILabel!
    @IBOutlet weak var MainImageView: CircleImageView!
    @IBOutlet weak var gradientView: GradientView!
    @IBAction func ButtonAction(_ sender: Any) {
        let vc = UserViewController()
        present(vc, animated: true, completion: nil)
    }
    
   // Экземпляр очереди операций:
    let myOperayionQueue = OperationQueue()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userRealm = self.database.getUserData()
        self.sortedUserRealmData(user: userRealm)
        useOperationQueue()
    }
    
    //реализация запроса к Api, сохранения в Realm и отображения с помощью OperationQueue:
    func useOperationQueue(){
        // операция загрузки и парсинга:
        let dowmlodOperation = DownloadOperation(token: Session.instance.token, userId: Session.instance.userId)
        myOperayionQueue.addOperation(dowmlodOperation)
        // операция сохранения полученных данных в RealmЖ
        let saveToRealmOperation = SaveToRealmDataOperation()
            // устанавливаем зависимость от операции загрузки и парсинга:
        saveToRealmOperation.addDependency(dowmlodOperation)
        myOperayionQueue.addOperation(saveToRealmOperation)
        // операция получения данных из Realm для отображения на дисплее:
        let displayDataOperation = DisplayDataOperation()
            // устанавливаем зависимость от операции сохранения данных в Realm:
        displayDataOperation.addDependency(saveToRealmOperation)
            // вывод работы с UI на главную очередь после завершения myOperayion:
        displayDataOperation.completionBlock = {
            OperationQueue.main.addOperation {
                self.MainNameLabel.text = displayDataOperation.firstName
                self.MainIdLabel.text = displayDataOperation.lastName
                let avatar = displayDataOperation.avatar
                let urlAvatar = URL(string: avatar ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg")
                self.MainImageView.kf.setImage(with: urlAvatar)
            }
        }
        myOperayionQueue.addOperation(displayDataOperation)
    }
    
    // сортировка полученных данных из Realm:
    func sortedUserRealmData(user: [UserRealm]){
        self.userRealm.forEach { user in
            self.MainNameLabel.text = user.firstName
            self.MainIdLabel.text = user.lastName
            let avatar = user.photo50
            let urlAvatar = URL(string: avatar )
            self.MainImageView.kf.setImage(with: urlAvatar)
        }
        
    }
      
}
