//
//  Item.swift
//  Todoey-iOS12
//
//  Created by USER on 2019-05-24.
//  Copyright © 2019 taka. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
