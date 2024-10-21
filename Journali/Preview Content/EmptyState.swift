//
//  EmptyState.swift
//  Journali
//
//  Created by Yomna Eisa on 20/10/2024.
//

// This file contains the code for the "Empty State" view. it shows when the user does not have any saved journals.

import SwiftUI

var purple = Color(red: 213 / 255, green: 201 / 255, blue: 253 / 255)

struct EmptyStateView: View {
  
    @State var shouldPresentSheet = false

    var body: some View {
        ZStack {
        
        Color.black.edgesIgnoringSafeArea(.all)
            
            HStack {
                Text("Journal").font(.largeTitle).foregroundStyle(.white).bold()
               
                Spacer()
                
                Image(systemName: "line.3.horizontal.decrease.circle.fill").font(.title).foregroundStyle(.gray).background(purple).clipShape(.circle) // Edit colors here
//                
//                Image(systemName: "plus.circle.fill").font(.title).foregroundStyle(.gray).background(purple).clipShape(.circle) // Edit colors here
//                // this is the gray .foregroundStyle(Color(red: 23 / 255, green: 24 / 255, blue: 27 / 255).opacity(0.3))
// }
            
                VStack {
                     Button(action: {
                         shouldPresentSheet.toggle()
                     }) {
                         // Create an image button with system icons
                         Label("", systemImage: "plus.circle.fill")
                             .foregroundColor(purple).font(.title).foregroundStyle(.gray)
                     }
                     .sheet(isPresented: $shouldPresentSheet) {
                       //  print("Sheet dismissed!")
                     } content: {
                         // Content of the sheet goes here
                         HStack {
                             Button(action: {}){
                                 Label("Cancel", systemImage: "")
                                     .foregroundColor(purple).foregroundStyle(.gray)
                             }
                             
                             Spacer()
                            
                             Button(action: {}){
                                 Label("Save", systemImage: "")
                                     .foregroundColor(purple).foregroundStyle(.gray)
                             } // End of button
                         }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // End of HStack
                     } // End of content
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(30)// End HStack
    
            VStack {
                Image("Icon").imageScale(.large).padding(10)
                Text("Begin Your Journal").font(.title).bold().foregroundStyle(purple).padding(3)
                
                Text("Craft your personal diary, tap the plus icon to begin").foregroundStyle(Color.white).frame(width: 200, height: 10, alignment: .center)
            }
                .padding(50)// End of VStack
                
        } // End of ZStack
    }
}

#Preview {
    EmptyStateView()
}
