//
//  WordModel.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 19.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import RealmSwift

class Word: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var translation: String = ""
    @objc dynamic var imageName: String?
    
    let group = LinkingObjects(fromType: Group.self, property: "words")
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, title: String, translation: String) {
         self.init()
        self.id = id
        self.title = title
        self.translation = translation
     }
}
