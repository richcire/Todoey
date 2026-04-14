//
//  Item.swift
//  Todoey
//
//  Created by 연민석 on 4/13/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation

class Item {
    var title: String = ""
    var done: Bool = false
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
