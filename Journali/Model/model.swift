//
//  model.swift
//  Journali
//
//  Created by Yomna Eisa on 23/10/2024.
//

import SwiftData
import Foundation

@Model
class Journal: Identifiable {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var content: String
    var isBookmarked: Bool
    
    init(title: String, date: Date, content: String, isBookmarked: Bool = false) {
        self.title = title
        self.date = date
        self.content = content
        self.isBookmarked = isBookmarked
    }
}


