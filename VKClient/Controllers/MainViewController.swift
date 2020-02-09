//
//  MainViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var apiService = ApiService()
    var useRealmData = UseRealmData()
    var userRealm = [UserRealm]()
    @IBOutlet weak var MainNameLabel: UILabel!
    @IBOutlet weak var MainIdLabel: UILabel!
    @IBOutlet weak var MainImageView: CircleImageView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var LightLabel: UILabel!
    @IBOutlet weak var DarkLabel: UILabel!
   
    
    @IBAction func DarkLightSwitch(_ sender: Any) {
        let changeColorNotification = Notification.Name("changeColorNotification")
        NotificationCenter.default.post(name: changeColorNotification, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.loadUserData()
        useRealmData.getUserData(){[weak self] userRealm in
            self?.userRealm = userRealm
            for i in userRealm{
                self?.MainNameLabel.text = i.firstName
                self?.MainIdLabel.text = i.lastName
                let avatar = i.photo50
                let urlAvatar = URL(string: avatar)!
                let dataAvatar = try? Data(contentsOf: urlAvatar)
                self?.MainImageView.image = UIImage(data: dataAvatar!)
            }
        }
    
               
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
