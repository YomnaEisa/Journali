//
//  EmptyState.swift
//  Journali
//
//  Created by Yomna Eisa on 20/10/2024.
//

// This file contains the code for the "Empty State" view. it shows when the user does not have any saved journals.

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ZStack {
        
        Color.black.edgesIgnoringSafeArea(.all)
            
            HStack {
                Text("Journal").font(.largeTitle).foregroundStyle(.white).bold()
                Spacer()
                Image(systemName: "line.3.horizontal.decrease.circle.fill").font(.title).foregroundStyle(.white).background(Color.red).padding(10) // Edit colors here
                Image(systemName: "plus.circle.fill").font(.title).foregroundStyle(.white) // Edit colors here
                // this is the gray .foregroundStyle(Color(red: 23 / 255, green: 24 / 255, blue: 27 / 255).opacity(0.3))
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(30)// End HStack
            
            VStack {
                Image("Icon").imageScale(.large).padding(10)
                Text("Begin Your Journal").font(.title).bold().foregroundStyle(Color(red: 213 / 255, green: 201 / 255, blue: 253 / 255)).padding(3)
                Text("Craft your personal diary, tap the plus icon to begin").foregroundStyle(Color.white)
            }
                .padding(50)// End of VStack
        } // End of ZStack
    }
}

#Preview {
    EmptyStateView()
}
