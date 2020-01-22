//
//  GroupModel.swift
//  SpanishHelper
//
//  Created by Ruslan Khamskyi on 17.01.2020.
//  Copyright © 2020 Ruslan Khamskyi. All rights reserved.
//

import RealmSwift

class Group: Object {
    
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var imageName: String?
    var words = List<Word>()

    override class func primaryKey() -> String? {
        return "id"
    }
}
