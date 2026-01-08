//
//  Item.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 08.01.26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
