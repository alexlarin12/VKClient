//
//  FriendsTVC+SearchBarDelegate.swift
//  VKClient
//
//  Created by Alex Larin on 15.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import UIKit
//@available(iOS 13.0, *)
extension FriendsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        do {
            self.friendsResult = searchText.isEmpty ?
                try database.getFriendData() :
                try database.searchFriends(lastName: searchText)
            let groupedFriends = Dictionary(grouping: friendsResult!) { $0.lastName.prefix(1) }
                       // Реализация группирования в секции
                       sortedFriendsResults = groupedFriends.map { Section(title: String($0.key), items: $0.value) }
                       sortedFriendsResults.sort { $0.title < $1.title }
            self.tableView.reloadData()
        } catch {
            print("Получили ошибку при поиске друзей: \(error)")
        }
        tableView.reloadData()
    }
    // Скрываем клавиатуру после нажатия "search"
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { view.endEditing(true) }
}
