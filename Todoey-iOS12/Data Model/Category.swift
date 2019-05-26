//
//  Category.swift
//  Todoey-iOS12
//
//  Created by USER on 2019-05-24.
//  Copyright © 2019 taka. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
