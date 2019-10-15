//
//  Category.swift
//  Todoey
//
//  Created by Chris Marler on 2019-10-12.
//  Copyright © 2019 Chris Marler. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
