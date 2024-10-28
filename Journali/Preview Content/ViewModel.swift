import SwiftUI
import SwiftData

class ViewModel: ObservableObject {
    @Environment(\.modelContext) var modelContext
    @Published var journalEntries: [Journal] = []
    @Published var searchText: String = ""
    @Published var selectedFilter: String = "All"
    @Published var isEditing: Bool = false
    @Published var shouldPresentSheet: Bool = false
    @Published var selectedJournal: Journal? = nil
    @Published var newJournal: Journal = Journal(title: "", date: Date(), content: "", isBookmarked: false)
    
    // Color Theme
            static let purple = Color(red: 213 / 255, green: 201 / 255, blue: 253 / 255)
            static let grey = Color(red: 27 / 255, green: 27 / 255, blue: 29 / 255)
            static let dateGrey = Color(red: 163 / 255, green: 154 / 255, blue: 154 / 255)
           // static let black = Color(red: 26 / 255, green: 26 / 255, blue: 28 / 255) // WRONG
            static let editPurple = Color(red: 127 / 255, green: 129 / 255, blue: 253 / 255)

    // Fetch journals from model context and filter them
//    func fetchJournals() {
//        // Assume fetching code here for modelContext
//        // self.journalEntries = fetchedJournals
//    }
    
//    init() {
//        loadJournals() // Load existing journals at app start
//    }

//    func loadJournals() {
//        let fetchRequest = FetchDescriptor<Journal>()
//        if let loadedJournals = try? modelContext.fetch(fetchRequest) {
//            journalEntries = loadedJournals
//            print("Journals loaded: \(journalEntries.count)")
//        }
//    }
//    

    var filteredJournals: [Journal] {
        var journalsToShow = journalEntries
        
        // Filter and search
        if selectedFilter == "Bookmarked" {
            journalsToShow = journalsToShow.filter { $0.isBookmarked }
        } else if selectedFilter == "Date" {
            journalsToShow.sort { $0.date > $1.date }
        }
        
        if !searchText.isEmpty {
            journalsToShow = journalsToShow.filter { $0.title.contains(searchText) || $0.content.contains(searchText) }
        }
        
        return journalsToShow.reversed()
    }
    
    func addOrEditJournal() {
        if isEditing, let selectedJournal = selectedJournal {
            // Update the existing journal
            selectedJournal.title = newJournal.title
            selectedJournal.content = newJournal.content
            selectedJournal.date = newJournal.date
        } else {
            modelContext.insert(newJournal)
            journalEntries.append(newJournal)
        }
        
        saveChanges()
       // try? modelContext.save()
       // loadJournals() // Refresh data
        resetJournalForm()
    }
    
    func deleteJournal(_ journal: Journal) {
        modelContext.delete(journal)
        journalEntries.removeAll { $0.id == journal.id }
        saveChanges()
      // try? modelContext.save()
       // loadJournals() // Refresh data

    }
    
    func resetJournalForm() {
        newJournal = Journal(title: "", date: Date(), content: "", isBookmarked: false)
        shouldPresentSheet = false
        isEditing = false
    }
    
    func toggleBookmark(for journal: Journal) {
        journal.isBookmarked.toggle()
        saveChanges()
      //  try? modelContext.save()

    }
    
    func saveChanges() {
       // try? modelContext.save()
               do {
                    try modelContext.save() // Save the context, which writes data to disk
                } catch {
                    print("Error saving data: \(error.localizedDescription)")
                }
    }
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
}
