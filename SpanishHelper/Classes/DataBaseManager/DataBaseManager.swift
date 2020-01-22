//
//  DataBaseManager.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 18.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//


import RealmSwift

final class DataBaseManager: NSObject {
    
    func addNewWord(word: Word) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(word, update: .all)
        }
    }
    
    func addNewWordToGroup(word: Word, group: Group) {
        let realm = try! Realm()
        try! realm.write {
            group.words.append(word)
        }
    }
    
    func getGroup(group: String) -> Group? {
        let realm = try! Realm()
        guard let group = realm.objects(Group.self).filter("title = \(group)").first else { return nil}
        return group
    }
    
    func getAllGroups() -> [Group] {
        let realm = try! Realm()
        let groups = Array(realm.objects(Group.self))
        // var allGroups = [Group]()
        return groups
    }
    
    func addGroup(group: Group) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(group, update: .all)
        }
    }
    
    func delete(group: Group) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(group, cascading: true)
        }
    }
    
    func updateGroupTitle(group: Group, newTitle: String) {
        let realm = try! Realm()
        try! realm.write {
            group.title = newTitle
        }
    }
    
}
