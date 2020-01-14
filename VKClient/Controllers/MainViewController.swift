//
//  MainViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.01.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

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
        let session = Session.instance
        self.MainNameLabel.text = "Token = \(session.token)"
        self.MainIdLabel.text = "User ID = \(session.userId)"
        self.view.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        let changeColorNotification = Notification.Name("changeColorNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(changeColor(notification:)), name: changeColorNotification, object: nil)
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
