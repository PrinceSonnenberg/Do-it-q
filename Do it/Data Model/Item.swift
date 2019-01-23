//
//  Item.swift
//  Do it
//
//  Created by Prince Sonnenberg on 2019/01/22.
//  Copyright © 2019 Prince Sonnenberg. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
@objc dynamic var title : String = " "
 @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
