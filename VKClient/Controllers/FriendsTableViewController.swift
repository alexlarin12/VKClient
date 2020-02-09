//
//  FriendsTableViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {
    var apiService = ApiService()
    var friendRealm = [FriendRealm]()
    var database = FriendsRepositiry()
    
    var friendsResult: Results<FriendRealm>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showFriends()
        apiService.loadFriendsData(token: Session.instance.token, userId: Session.instance.userId) { result in
            switch result{
            case .success(let friends):
                self.database.saveFriendData(friends: friends)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    deinit {
        token?.invalidate()
    }
    
    func showFriends(){
           do{
               friendsResult = try database.getFriendData()
               token = friendsResult?.observe { [weak self] results in
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
        // #warning Incomplete implementation, return the number of rows
        return friendsResult?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsIdentifier", for: indexPath) as? FriendsCell,
            let friend = friendsResult?[indexPath.row] else {
                return UITableViewCell()
        }
        let avatar = friend.photo50
        let urlAvatar = URL(string: avatar)!
        let dataAvatar = try? Data(contentsOf: urlAvatar)
        let fullName = friend.firstName + " " + friend.lastName
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
            let name = (friendsResult?[indexPath.row].firstName ?? "") + " " + (friendsResult?[indexPath.row].lastName ?? "")
            let image = friendsResult?[indexPath.row].photo50
            let ownerId = friendsResult?[indexPath.row].id
            friendCollectionViewController.friendNameForTitle = name
            friendCollectionViewController.friendImageForCollection = image ?? ""
            friendCollectionViewController.friendOwnerId = ownerId ?? 0
        }
    }
}

