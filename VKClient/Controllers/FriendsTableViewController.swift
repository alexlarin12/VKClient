//
//  FriendsTableViewController.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

struct Section<T> {
    var title: String
    var items: [T]
}

class FriendsTableViewController: UITableViewController {
    var apiService = ApiService()
    var database = FriendsRepositiry()
    
    var friendsResult: Results<FriendRealm>?
    var sortedFriendsResults = [Section<FriendRealm>]()
    var token: NotificationToken?
    
    @IBOutlet weak var FriendsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FriendsSearchBar.delegate = self
        
       // self.showFriends()
        self.getFriendsFromDatabase()
        apiService.loadFriendsData(token: Session.instance.token, userId: Session.instance.userId) { result in
            switch result{
            case .success(let friends):
                self.database.saveFriendData(friends: friends)
                self.getFriendsFromDatabase()
            case .failure(let error):
                print(error)
            }
        }
        updateNavigationBar()
    }
    
    deinit {
        token?.invalidate()
    }
    
    private func getFriendsFromDatabase() {
           do {
               // Получаем список всех друзей
               self.friendsResult = try database.getFriendData()
               self.makeSortedSections()
               self.tableView.reloadData()
           } catch {
            print(error)
            
        }
    }
    
    func showFriends(){
           do{
               friendsResult = try database.getFriendData()
               makeSortedSections()//new
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
    func updateNavigationBar() {
        let backButtonItem = UIBarButtonItem()  //Убираем надпись на кнопке возврата
        backButtonItem.title = ""
        backButtonItem.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
    }
    private func makeSortedSections() {
        let groupedFriends = Dictionary.init(grouping: friendsResult!) {
            $0.lastName.prefix(1) }
            sortedFriendsResults = groupedFriends.map { Section(title: String($0.key), items: $0.value) }
            sortedFriendsResults.sort { $0.title < $1.title }
    }
    
    func getModelAtIndex(indexPath: IndexPath) -> FriendRealm? {
        return sortedFriendsResults[indexPath.section].items[indexPath.row]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedFriendsResults.count
    }
    
    /* override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedFriendsResults.map {
            $0.title }
    }
    */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let view = UIView()
           view.backgroundColor = #colorLiteral(red: 0.2403630912, green: 0.4364806414, blue: 0.8139752746, alpha: 1)
           let label = UILabel()
           label.text = sortedFriendsResults[section].title
           label.frame = CGRect(x: 10, y: 5, width: 14, height: 15)
           label.textColor = UIColor.white
           label.adjustsFontSizeToFitWidth = true
           view.addSubview(label)
           return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortedFriendsResults[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsIdentifier", for: indexPath) as? FriendsCell,
            let friend = getModelAtIndex(indexPath: indexPath) else {
                return UITableViewCell()
        }
        let avatar = friend.photo50
        let urlAvatar = URL(string: avatar)
       // let dataAvatar = try? Data(contentsOf: urlAvatar)
        let fullName = friend.firstName + " " + friend.lastName
            cell.FriendNameLabel.text = fullName
           // cell.FriendsAvatarImageView.image = UIImage(data: dataAvatar!)
        cell.FriendsAvatarImageView.kf.setImage(with: urlAvatar)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "WatchFriend",
            let friendViewController = segue.destination as? FriendViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            print(indexPath)
            let name = (getModelAtIndex(indexPath: indexPath)?.firstName ?? "") + " " + (getModelAtIndex(indexPath: indexPath)?.lastName ?? "")
            let image = getModelAtIndex(indexPath: indexPath)?.photo50
            let ownerId = getModelAtIndex(indexPath: indexPath)?.id
            friendViewController.friendNameForTitle = name
            friendViewController.friendImageForCollection = image ?? ""
            friendViewController.friendOwnerId = ownerId ?? 0
        }
    }
}
