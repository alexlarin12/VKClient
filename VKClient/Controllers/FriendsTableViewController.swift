//
//  FriendsTableViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    var apiService = ApiService()
    var friendRealm = [FriendRealm]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.loadFriendsData() { [weak self] friendRealm in
            self?.friendRealm = friendRealm
            self?.tableView.reloadData()
            print(friendRealm.count)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendRealm.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsIdentifier", for: indexPath) as! FriendsCell
        let avatar = friendRealm[indexPath.row].photo50
        let urlAvatar = URL(string: avatar)!
        let dataAvatar = try? Data(contentsOf: urlAvatar)
        let fullName = friendRealm[indexPath.row].firstName + " " + friendRealm[indexPath.row].lastName
            cell.FriendNameLabel.text = fullName
            cell.FriendsAvatarImageView.image = UIImage(data: dataAvatar!)
        return cell
    }
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WatchFriend",
            let friendCollectionViewController = segue.destination as? FriendCollectionViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            let name = friendRealm[indexPath.row].firstName + " " + friendRealm[indexPath.row].lastName
            let image = friendRealm[indexPath.row].photo50
            let ownerId = friendRealm[indexPath.row].id
            friendCollectionViewController.friendNameForTitle = name
            friendCollectionViewController.friendImageForCollection = image
            friendCollectionViewController.friendOwnerId = ownerId
        }
    }
}

