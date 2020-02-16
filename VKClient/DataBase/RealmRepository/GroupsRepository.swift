//
//  GroupsRepository.swift
//  VKClient
//
//  Created by Alex Larin on 04.02.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
import RealmSwift
class GroupsRepository{
    
    var groupRealm = [GroupRealm]()
    
    func saveGroupData(groups: [ItemsGroup]){
         do {
            let realm = try Realm()
            realm.beginWrite()
            var groupsToAdd = [GroupRealm]()
            groups.forEach { group in
                let groupRealm = GroupRealm()
                groupRealm.id = group.id
                groupRealm.name = group.name
                groupRealm.screenName = group.screenName
                groupRealm.isClosed = group.isClosed
                groupRealm.type = group.type
                groupRealm.isAdmin = group.isAdmin
                groupRealm.isMember = group.isMember
                groupRealm.isAdvertiser = group.isAdvertiser
                groupRealm.site = group.site
                groupRealm.photo50 = group.photo50
                groupRealm.photo100 = group.photo100
                groupRealm.photo200 = group.photo200
                groupsToAdd.append(groupRealm)
            }
            realm.add(groupsToAdd, update: .modified)
            try realm.commitWrite()
         } catch  {
             print(error)
         }
     }
     func getGroupData() throws -> Results<GroupRealm> {
         do {
            let realm = try Realm()
            return realm.objects(GroupRealm.self)
         } catch {
             throw error
         }
     }
}
