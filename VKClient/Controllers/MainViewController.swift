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
    @IBOutlet weak var MainNameLabel: UILabel!
    @IBOutlet weak var MainIdLabel: UILabel!
    @IBOutlet weak var MainImageView: CircleImageView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var LightLabel: UILabel!
    @IBOutlet weak var DarkLabel: UILabel!
   // Экземпляр очереди операций:
    let myOperayionQueue = OperationQueue()
    
    @IBAction func DarkLightSwitch(_ sender: Any) {
        let changeColorNotification = Notification.Name("changeColorNotification")
        NotificationCenter.default.post(name: changeColorNotification, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // путь к папкам caches, document, tmp
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let tmpDirectory = FileManager.default.temporaryDirectory
        print(cachesDirectory!)
        print(documentDirectory!)
        print(tmpDirectory)
        // create URL for TextFile in tmpDirectory:
        let testFile = tmpDirectory.appendingPathComponent("textFile.txt").path
        let testImageFile = tmpDirectory.appendingPathComponent("image.png").path
        // delete old files:
        do {
            try FileManager.default.removeItem(atPath: testFile)
            try FileManager.default.removeItem(atPath: testImageFile)
        } catch  {
            print(error)
        }

        print(testFile) // print path
        // exist or dont exist:
        var fileExist = FileManager.default.fileExists(atPath: testFile)
        print("File Exist \(fileExist)")//print result
        // create date for file:
        let data = "Hello world!".data(using: .utf8)
        // create file
        FileManager.default.createFile(atPath: testFile, contents: data, attributes: nil)
        fileExist = FileManager.default.fileExists(atPath: testFile)
        // get text
        let text = try? String(contentsOfFile: testFile)
        print(text ?? "no text")
        print("File Exist \(fileExist)")
        
       
        let dataImage = UIImage(named: "cat5")?.pngData()
        FileManager.default.createFile(atPath: testImageFile, contents: dataImage, attributes: nil)
        let image = UIImage(contentsOfFile: testImageFile)
        fileExist = FileManager.default.fileExists(atPath: testImageFile)
        print("image exist \(fileExist)")
        print("image exist \(String(describing: image))")
       
        
        
     
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
                self.MainNameLabel.text = displayDataOperation.mainNameLabel
                self.MainIdLabel.text = displayDataOperation.mainIdLabel
                let avatar = displayDataOperation.avatar
                let urlAvatar = URL(string: avatar ?? "https://sun9-63.userapi.com/c627628/v627628412/3aa85/EwORTurDS_k.jpg")
                self.MainImageView.kf.setImage(with: urlAvatar)
            }
        }
        myOperayionQueue.addOperation(displayDataOperation)
        
     /*
        apiService.loadUserData(token: Session.instance.token, userId: Session.instance.userId) { [weak self] user in
    
            self?.database.saveUserData(user: user)
        }
            
            self.userRealm = self.database.getUserData()
            self.userRealm.forEach { user in
                self.MainNameLabel.text = user.firstName
                self.MainIdLabel.text = user.lastName
                let avatar = user.photo50
                let urlAvatar = URL(string: avatar)
                self.MainImageView.kf.setImage(with: urlAvatar)
            }
    */
               
        self.view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        let changeColorNotification = Notification.Name("changeColorNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(changeColor(notification:)), name: changeColorNotification, object: nil)
    }
       @objc func changeColor(notification:Notification){
        if self.view.backgroundColor == #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1) {
            self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.MainNameLabel.textColor = #colorLiteral(red: 0.0769745335, green: 0.09174961597, blue: 0.08340293914, alpha: 1)
            self.MainIdLabel.textColor = #colorLiteral(red: 0.0769745335, green: 0.09174961597, blue: 0.08340293914, alpha: 1)
            self.gradientView.startColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            self.gradientView.endColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            self.DarkLabel.textColor = #colorLiteral(red: 0.0769745335, green: 0.09174961597, blue: 0.08340293914, alpha: 1)
            self.LightLabel.textColor = #colorLiteral(red: 0.0769745335, green: 0.09174961597, blue: 0.08340293914, alpha: 1)
        }else{
            self.view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            self.MainNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.MainIdLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.gradientView.startColor = #colorLiteral(red: 0.2397964597, green: 0.4241903424, blue: 0.8061572313, alpha: 1)
            self.gradientView.endColor = #colorLiteral(red: 0.1754406691, green: 0.3129038811, blue: 0.5856842399, alpha: 1)
            self.DarkLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.LightLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
