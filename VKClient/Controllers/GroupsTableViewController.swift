//
//  GroupsTableViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    var apiService = ApiService()
    var groupRealm = [GroupRealm]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.loadGroupsData(){[weak self] groupRealm in
            self?.groupRealm = groupRealm
            self?.tableView.reloadData()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupRealm.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsIdentifire", for: indexPath) as! GroupsCell
        let avatar = groupRealm[indexPath.row].photo50
        let urlAvatar = URL(string: avatar)!
        let dataAvatar = try? Data(contentsOf: urlAvatar)
            cell.GroupsNameLabel.text = groupRealm[indexPath.row].name
            cell.GroupsAvatarImageView.image = UIImage(data: dataAvatar!)
        return cell
    }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
