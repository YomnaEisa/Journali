//
//  EmptyState.swift
//  Journali
//
//  Created by Yomna Eisa on 20/10/2024.
//

// This file contains the code for the "Empty State" view. it shows when the user does not have any saved journals.

import SwiftUI
import Foundation
import SwiftData



struct EmptyStateView: View {
  
    let purple = Color(red: 213 / 255, green: 201 / 255, blue: 253 / 255)
    let grey = Color(red: 45 / 255, green: 45 / 255, blue: 47 / 255)
    let editPurple = Color(red: 127 / 255, green: 129 / 255, blue: 253 / 255)

    @State var shouldPresentSheet = false
    //@State private var title: String = ""
    //@State private var journalContent : String = ""
    let date = Date()
    // the data is saved in this format
    // [[title, date, journalcontent] , [title, date, journalcontent] , [title, date, journalcontent] ]
    @Environment(\.dismiss) var dismiss //for the cancel button
    @Environment(\.modelContext) private var modelContext
    @State private var journal = Model(title: " ", date: Date(), content: " ", isBookmarked: false)
    @Query var journalEntries: [Model] // Automatically fetches all journal entries
    @State private var isEditing = false
    @State private var selectedJournal: Model? = nil // Track the journal entry being edited
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "All" // Track selected filter



    
    // Computed property to filter journal entries based on search text and filter button
    var filteredJournals: [Model] {
        var journalsToShow = journalEntries

        switch selectedFilter {
        case "Bookmarked":
            journalsToShow = journalsToShow.filter { $0.isBookmarked }
        case "Date":
            journalsToShow.sort { $0.date > $1.date } // Sort by date, latest first
        default:
            break
        }
        
        // Apply search filter
        if !searchText.isEmpty {
            journalsToShow = journalsToShow.filter { $0.title.contains(searchText) || $0.content.contains(searchText) }
        }
        
        return journalsToShow
    }



    var body: some View {
            ZStack {
                
                //  Color.black.edgesIgnoringSafeArea(.all)
                Color.black.ignoresSafeArea()
                
                HStack {
                    Text("Journal").font(.largeTitle).foregroundStyle(.white).bold()
                    
                    Spacer()
                    
//                    Image(systemName: "line.3.horizontal.decrease.circle.fill").font(.largeTitle) .foregroundStyle(purple, grey).font(.title).clipShape(.circle)
                    
                    Menu {
                        Button {
                            // Toggle Bookmarked filter
                            if selectedFilter == "Bookmarked" {
                                selectedFilter = ""
                            } else {
                                selectedFilter = "Bookmarked"
                            }
                        } label: {
                            Label("Bookmarked", systemImage: selectedFilter == "Bookmarked" ? "checkmark" : "")
                        }
                        
                        Button {
                            // Toggle Date filter
                            if selectedFilter == "Date" {
                                selectedFilter = ""
                            } else {
                                selectedFilter = "Date"
                            }
                        } label: {
                            Label("Date", systemImage: selectedFilter == "Date" ? "checkmark" : "")
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(purple, grey)
                            .clipShape(Circle())
                    }


                    
                    // Edit colors here
                    //
                    //                Image(systemName: "plus.circle.fill").font(.title).foregroundStyle(.gray).background(purple).clipShape(.circle) // Edit colors here
                    //                // this is the gray .foregroundStyle(Color(red: 23 / 255, green: 24 / 255, blue: 27 / 255).opacity(0.3))
                    // }
                    
                    VStack {
                        Button(action: {
                            // Reset journal and editing state for adding a new entry
                            journal = Model(title: "", date: Date(), content: "", isBookmarked: false)
                            isEditing = false
                            shouldPresentSheet.toggle()
                        }) {
                            // Create an image button with system icons
                            Label("", systemImage: "plus.circle.fill")
                                .foregroundStyle(purple,grey).font(.largeTitle)
                        }
                        .sheet(isPresented: $shouldPresentSheet, content: {
                            // Content of the sheet goes here
                            ZStack {
                                //    Color.black.ignoresSafeArea()
                                
                                HStack {
                                    Button(action: { //dismiss()
                                        shouldPresentSheet = false
                                    }){
                                        Label("Cancel", systemImage: "")
                                            .foregroundColor(purple).foregroundStyle(.gray)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {//journal.saveEntry(using: modelContext)
                                        
                                        if isEditing{
                                            //let selectedJournal = selectedJournal
                                            //modelContext.insert(journal) // Save changes to the journal entry
                                            
                                            selectedJournal?.title = journal.title
                                            selectedJournal?.content = journal.content
                                            selectedJournal?.date = journal.date
                                            
                                        } else {
                                            modelContext.insert(journal) // Insert new journal entry
                                        }
                                        
                                        //dismiss()
                                        shouldPresentSheet = false
                                        
                                    }){
                                        Label("Save", systemImage: "")
                                            .foregroundColor(purple).foregroundStyle(.gray)
                                    } // End of button
                                    
                                }
                                .padding() // Adds padding to the buttons
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // End of HStack
                                
                                // heres where the title and journal content is written
                                VStack{
                                    TextField("Title",
                                              text: $journal.title).font(.largeTitle)
                                    
                                    Text(getCurrentDate())
                                    // .font(.title)
                                    //  .fontWeight(.bold)
                                    // .padding()
                                        .foregroundStyle(.gray)
                                        .frame(width: 205, height: 30, alignment: .leading)
                                    // .padding()
                                    
                                    
                                    TextField("Type your journal...",
                                              text: $journal.content).font(.body).foregroundStyle(.gray)
                                        .padding(.top, 10)
                                    
                                }.padding()
                                    .frame(width: 400, height: 650, alignment: .topLeading) // end of vstack
                                
                            } // end of ZStack
                            // .background(Color.black.edgesIgnoringSafeArea(.all))
                        }) // End of content
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(30)// End HStack
                
                VStack {
                    
                    if journalEntries.isEmpty {
                        Image("Icon").imageScale(.large).padding(10)
                        Text("Begin Your Journal").font(.title).bold().foregroundStyle(purple).padding(3)
                        
                        Text("Craft your personal diary, tap the plus icon to begin").fixedSize().foregroundStyle(Color.white).frame(width: 200, height: 10, alignment: .center)
                    } else {
                        NavigationView {
                            List(filteredJournals, id: \.self) { journal in
                                Section{
                                    VStack {
                                        HStack {
                                            Text(journal.title)
                                                .font(.largeTitle)
                                                .foregroundStyle(purple)
                                                .bold()
                                            Spacer()
                                           
                                            Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark") // Change icon based on bookmark status
                                                .foregroundStyle(journal.isBookmarked ? purple : .gray) // Change color based on bookmark status
                                                .font(.title)
                                                .onTapGesture {
                                                    journal.isBookmarked.toggle() // Toggle the bookmark status
                                                    try? modelContext.save() // Save the context to persist the change
                                                }

                                        }
                                        .frame(width: 340, height: 50, alignment: .leading) // End of HStack that has title and bookmark
                                        
                                        VStack {
                                            Text(formatDate(journal.date)) // Display the date of the journal
                                                .foregroundStyle(.gray)
                                                .frame(width: 300, height: 70, alignment: .leading)
                                            
                                            Text(journal.content) // Display the journal content
                                                .font(.body)
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 400, height: 70, alignment: .leading)
                                        .padding() // End of VStack that has date and journal content
                                    }
                                    .listRowBackground(grey)
                                    .swipeActions(edge: .leading) {
                                        Button{
                                            selectedJournal = journal // Set the selected journal to edit
                                            self.journal = journal // Copy selected journal's data into the journal state variable
                                            shouldPresentSheet = true
                                            isEditing = true
                                        }label: {
                                            Image(systemName: "pencil") // Use a pencil icon for editing
                                                .foregroundColor(.white) // Change the icon color if needed
                                        }
                                        .tint(editPurple) // Set the swipe button color
                                    } // end of left swip for editing
                                    
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            modelContext.delete(journal) // Delete the journal entry
                                            try? modelContext.save() // Save the context to persist deletion
                                        }
                                        label: {
                                                Image(systemName: "trash") // Use a trash icon for deleting
                                                    .foregroundColor(.white) // Change the icon color if needed
                                            }
                                    } // end of right swipe for deleting
                                    
                                    // .padding(.vertical, 10)
                                    //.padding() // End of VStack that has all the contents of the list
                                } // end of selection
                                .frame(width: 400, height: 200, alignment: .top)
                                
                               } // end of nav
                            .background(Color.black.ignoresSafeArea())
                            
                        
                        }.searchable(text: $searchText) // Add the search bar
                                .scrollContentBackground(.hidden)
                                .frame(width: 400, height: 650)
                        
                    } // end of else
                }
                .padding(50)// End of VStack
                
            } // End of ZStack
    }
}


// functions


// Function to get today's date in "dd/MM/yyyy" format
func getCurrentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let currentDate = Date()
    return dateFormatter.string(from: currentDate)
}

func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.string(from: date)
}



#Preview {
    EmptyStateView()
        .modelContainer(for: Model.self)
}

// Label("", systemImage: "plus.circle.fill").foregroundStyle(purple,grey).font(.largeTitle)
