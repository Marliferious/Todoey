//
//  Item.swift
//  Todoey
//
//  Created by Chris Marler on 2019-10-12.
//  Copyright © 2019 Chris Marler. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

