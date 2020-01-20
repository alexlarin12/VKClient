//
//  GroupsTableViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    var vkService = VKService()
    var groups:[GroupsModel] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        vkService.loadGroupsData()
       
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsIdentifire", for: indexPath) as! GroupsCell
            cell.GroupsNameLabel.text = groups[indexPath.row].groupName
            cell.GroupsAvatarImageView.image = UIImage(named: groups[indexPath.row].groupImage)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue){
       if segue.identifier == "addGroup"{
            guard let allGroupsTableViewController = segue.source as? AllGroupsTableViewController
                else {return}
        
            if let indexPath = allGroupsTableViewController.tableView.indexPathForSelectedRow{
                let group = allGroupsTableViewController.groups[indexPath.row]
                if !groups.contains(where: {$0.groupName == group.groupName}){
                   groups.append(group)
                   tableView.reloadData()
                }
         
            }
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    

}
