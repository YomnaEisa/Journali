//
//  EmptyState.swift
//  Journali
//
//  Created by Yomna Eisa on 20/10/2024.
//


import SwiftUI
import Foundation
import SwiftData

struct MainView: View {

    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        ZStack {
         Color.black.ignoresSafeArea()

            HStack {
                Spacer()

                Menu {
                    Button {
                        viewModel.selectedFilter = (viewModel.selectedFilter == "Bookmarked") ? "All" : "Bookmarked"
                    } label: {
                        Label("Bookmarked", systemImage: viewModel.selectedFilter == "Bookmarked" ? "checkmark" : "")
                    }
                    
                    Button {
                        viewModel.selectedFilter = (viewModel.selectedFilter == "Date") ? "All" : "Date"
                    } label: {
                        Label("Date", systemImage: viewModel.selectedFilter == "Date" ? "checkmark" : "")
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(ViewModel.purple, ViewModel.grey)
                        .clipShape(Circle())
                }
            
                
                VStack {
                    Button(action: {
                        viewModel.resetJournalForm()
                        viewModel.shouldPresentSheet.toggle()
                    }) {
                        Label("", systemImage: "plus.circle.fill")
                            .foregroundStyle(ViewModel.purple, ViewModel.grey)
                            .font(.largeTitle)
                    }
                }
            }
            .padding(30)
            .frame(width: 400, height: 780, alignment: .topLeading)
            
            Text("Journal")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .bold()
                .frame(width: 350, height: 650, alignment: .topLeading)


            VStack {
                if $viewModel.journalEntries.isEmpty {
                    Image("Icon")
                        .imageScale(.large)
                        .padding(10)
                    
                    Text("Begin Your Journal")
                        .font(.title)
                        .bold()
                        .foregroundStyle(ViewModel.purple)
                        .padding(3)
                    
                    Text("Craft your personal diary, tap the \n plus icon to begin")
                        .fixedSize()
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 50, alignment: .center)
                } else {
                    NavigationView {
                        List(viewModel.filteredJournals, id: \.self) { journal in
                            Section {
                                VStack{
                                    HStack {
                                        Text(journal.title)
                                            .padding()
                                            .font(.largeTitle)
                                            .foregroundStyle(ViewModel.purple)
                                            .bold()
                                       Spacer()
                                        Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                                            .foregroundStyle(ViewModel.purple)
                                            .font(.title)
                                            .onTapGesture {
                                                viewModel.toggleBookmark(for: journal)
                                            }
                                    }
                                    .frame(width: 350, height: 50, alignment: .trailing) // Frame for cells

                                    Text(viewModel.formatDate(journal.date))
                                        .foregroundStyle(ViewModel.dateGrey)
                                        .frame(width: 310, height: 10, alignment: .leading)

                                    
                                    Text(journal.content)
                                        .foregroundStyle(.white)
                                        .frame(width: 310, height: 50, alignment: .leading)
                                
                                }
                                .frame(width: 300, height: 200, alignment: .top) // Frame added
                                .listRowBackground(ViewModel.grey)
                                .swipeActions(edge: .leading) {
                                    Button {
                                        viewModel.selectedJournal = journal
                                        viewModel.newJournal = journal
                                        viewModel.shouldPresentSheet = true
                                        viewModel.isEditing = true
                                    } label: {
                                        Image(systemName: "pencil")
                                    }
                                    .tint(ViewModel.editPurple)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        viewModel.deleteJournal(journal)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                } // End of swipe action for delete
                            }
                                // end of nav
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.black.ignoresSafeArea())
                        .ignoresSafeArea(edges: .bottom)
                   }
                    .searchable(text: $viewModel.searchText)
                    .frame(width: 400, height: 580) // end of section
                }
            }
            .padding(30)
            .sheet(isPresented: $viewModel.shouldPresentSheet) {
                ZStack {
                    ViewModel.grey // Set the background color to grey
                        .ignoresSafeArea()

                    VStack(spacing: 0) { // Use a VStack to stack buttons on top
                        HStack {
                            Button("Cancel") {
                                viewModel.resetJournalForm()
                            }
                            .foregroundStyle(ViewModel.purple)

                            Spacer()

                            Button("Save") {
                                viewModel.addOrEditJournal()
                            }
                            .foregroundStyle(ViewModel.purple)
                            .bold()
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                        VStack {
                            TextField("Title", text: $viewModel.newJournal.title)
                                .font(.system(.largeTitle, weight: .bold))
                                .foregroundStyle(.white)
                                //.fontWeight(.Dark)
                                .frame(width: 400, height: 30, alignment: .leading)

                            Text(viewModel.getCurrentDate())
                                .foregroundStyle(ViewModel.dateGrey)
                                .frame(width: 400, height: 50, alignment: .leading)


                            TextField("Type your journal...", text: $viewModel.newJournal.content)
                                .font(.system(.title3))
                                .foregroundStyle(.white)
                                .padding(.top, 10)
                                .frame(width: 400, height: 60, alignment: .leading)
                        
                        }
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .padding()
                        .frame(width: 400, height: 650, alignment: .topLeading)
                    } // End of VStack
                } // End of ZStack
                .ignoresSafeArea(.keyboard, edges: .bottom)
            } // End of sheet
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
        .modelContainer(for: Journal.self)
}
