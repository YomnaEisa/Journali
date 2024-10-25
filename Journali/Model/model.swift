//
//  model.swift
//  Journali
//
//  Created by Yomna Eisa on 23/10/2024.
//

import Foundation
import SwiftData

@Model // This is required to define this as a model in swift data
final class Model {
    var title: String
    var date: Date
    var content: String
    var isBookmarked: Bool
    
    init(title: String, date: Date, content: String , isBookmarked: Bool) {
        var _: Data

        self.title = title
        self.date = date
        self.content = content
        self.isBookmarked = isBookmarked
    }
    
    
//    // Function to save the journal entry
//    func saveEntry(using modelContext: ModelContext) {
//        modelContext.insert(self)
//       // modelContext.save()
//
//        do {
//            try modelContext.save() // Save the context, which writes data to disk
//        } catch {
//            print("Error saving data: \(error.localizedDescription)")
//        }
//        
//        // Clear input fields after saving
////        title = ""
////        content = ""
////        
////                do {
////                    try modelContext.save()
////                } catch {
////                    print("Failed to insert new entry: \(error.localizedDescription)") // Handle errors properly
////                }
//    }
    
    
    
//    func fetchAllEntries() -> [Model] {
//        do {
//            let entries = try modelContext?.fetch(FetchRequest<JournalEntry>())
//            return entries
//        } catch {
//            print("Failed to fetch entries: \(error)")
//            return []
//        }
//    }
    
} // end of class


