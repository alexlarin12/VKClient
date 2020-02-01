//
//  FriendsTableViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    var vkService = VKService()
    var saveRealmData = SaveRealmData()
    var friends = [ItemsFriend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkService.loadFriendsData(){ result in
            switch result{
            case .success(let friends):
                self.friends = friends
                self.tableView.reloadData()
                self.saveRealmData.saveFriendData(friends: friends)
                print(friends.count)
            case .failure(let error):
                print(error)
            }
        }
       //  self.saveRealmData.saveFriendData(friends: friends)
        
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsIdentifier", for: indexPath) as! FriendsCell
        let avatar = friends[indexPath.row].photo50
        let urlAvatar = URL(string: avatar)!
        let dataAvatar = try? Data(contentsOf: urlAvatar)
        let fullName = friends[indexPath.row].firstName + " " + friends[indexPath.row].lastName
        
            cell.FriendNameLabel.text = fullName
            cell.FriendsAvatarImageView.image = UIImage(data: dataAvatar!)
        // Configure the cell...

        return cell
    }
    
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WatchFriend",
            let friendCollectionViewController = segue.destination as? FriendCollectionViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            let name = friends[indexPath.row].firstName + " " + friends[indexPath.row].lastName
            let image = friends[indexPath.row].photo50
            let ownerId = friends[indexPath.row].id
            friendCollectionViewController.friendNameForTitle = name
            friendCollectionViewController.friendImageForCollection = image
            friendCollectionViewController.friendOwnerId = ownerId
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
   
}
