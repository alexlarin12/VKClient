//
//  GroupsTVC+SearchBarDelegate.swift
//  VKClient
//
//  Created by Alex Larin on 15.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import UIKit
extension GroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        do {
            self.groupsResult = searchText.isEmpty ?
                try database.getGroupData() :
                try database.searchGroups(name: searchText.lowercased())
        } catch {
            print("Получили ошибку при поиске групп: \(error)")
        }
        tableView.reloadData()
    }
    // Скрываем клавиатуру после нажатия "search"
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { view.endEditing(true) }
}
