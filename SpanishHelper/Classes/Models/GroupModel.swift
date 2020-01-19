//
//  GroupModel.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 17.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import RealmSwift

class Group: Object {
    
    @objc dynamic var title: String?
    @objc dynamic var imageName: String?
    var words = List<Word>()
    
//    init(title: String, imageName: String) {
//        self.title = title
//        self.imageName = imageName
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
    override class func primaryKey() -> String? {
        return "title"
    }
}

class Word: Object {
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var translation: String?
    @objc dynamic var imageName: String?
    
    let stands = LinkingObjects(fromType: Group.self, property: "words")
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
