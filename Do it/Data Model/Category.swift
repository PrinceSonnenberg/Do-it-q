//
//  Category.swift
//  Do it
//
//  Created by Prince Sonnenberg on 2019/01/22.
//  Copyright © 2019 Prince Sonnenberg. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    
    @objc dynamic var name: String = " "
    let items = List<Item>()
    
}
