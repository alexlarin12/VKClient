//
//  GroupsTableViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class GroupsTableViewController: UITableViewController {
    var apiService = ApiService()
    var groupRealm = [GroupRealm]()
    var database = GroupsRepository()
    
    var groupsResult: Results<GroupRealm>?
    var token: NotificationToken?
    
    @IBOutlet weak var GroupSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GroupSearchBar.delegate = self
        hideKeyboardOnTap()
        self.showGroups()
        self.getGroupsFronApi()
    }
    deinit {
        token?.invalidate()
    }
    
    // метод получения групп из Api:
    func getGroupsFronApi(){
        apiService.loadGroupsData(token: Session.instance.token, userId: Session.instance.userId)
        .done { groups in
            self.database.saveGroupData(groups: groups)
            self.showGroups()}
        .recover({(error) in
            return self.apiService.loadGroupsData(token: Session.instance.token, userId: Session.instance.userId)
        .done { groups in
            self.database.saveGroupData(groups: groups)
            self.showGroups()}
        }).catch { error in
            print("Мы получили ошибку на странице групп: \(error)")
            }
    }
    // метод получения групп из Realm:
    func showGroups(){
        do{
            groupsResult = try database.getGroupData()
            token = groupsResult?.observe { [weak self] results in
                switch results{
                case .error(let error):
                    print(error)
                case .initial:
                    self?.tableView.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    self?.tableView.beginUpdates()
                    self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .none)
                    self?.tableView.endUpdates()
                }
            }
                
        }catch{
            print(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsResult?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if groupsResult?[indexPath.row].isMember != 0{
            return 75
        }else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsIdentifire", for: indexPath) as? GroupsCell,
        let group = groupsResult?[indexPath.row] else {
            return UITableViewCell()
        }
        let avatar = group.photo50
        let urlAvatar = URL(string: avatar)!
            cell.GroupsNameLabel.text = group.name
           // получение картинки с помощью KingFisher:
            cell.GroupsAvatarImageView.kf.setImage(with: urlAvatar)
            return cell
    }
    // метод удаления группы с экрана:
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupRealm.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBAction func addGroup(segue: UIStoryboardSegue){
     /*  if segue.identifier == "addGroup"{
            guard let allGroupsTableViewController = segue.source as? AllGroupsTableViewController
                else {return}
        
            if let indexPath = allGroupsTableViewController.tableView.indexPathForSelectedRow{
               let group = allGroupsTableViewController.groups[indexPath.row]
               if !groups.contains(where: {$0.name == group.groupName}){
                   groups.append(group)
                   tableView.reloadData()
                }
         
            }
        }
*/
    }
    // скрываем клавиатуру при нажатии на экран:
    func hideKeyboardOnTap() {
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideAction)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

