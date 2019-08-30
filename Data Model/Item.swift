//
//  Item.swift
//  Todoey
//
//  Created by Chris Marler on 2019-08-30.
//  Copyright © 2019 Chris Marler. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
  // Course mentiones that  Class Item: Codable will allow inheritance of Encodable and Decodable, but I left it in
    
    var title : String = ""
    var done : Bool = false
    
}
