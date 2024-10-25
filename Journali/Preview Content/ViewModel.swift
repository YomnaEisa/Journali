//
//  ViewModel.swift
//  Journali
//
//  Created by Yomna Eisa on 23/10/2024.
//

import SwiftUI

struct ViewModel: View {
    var body: some View {
       
    let grey = Color(red: 45 / 255, green: 45 / 255, blue: 47 / 255)
    let purple = Color(red: 213 / 255, green: 201 / 255, blue: 253 / 255)

           // Color.black.ignoresSafeArea()
            List {
                //  HStack{
                VStack(alignment: .leading, spacing: 115){
                    
                    HStack{
                        Text("My Birthday").font(.largeTitle).foregroundStyle(purple).bold()
                        Spacer()
                        Image(systemName: "bookmark").foregroundStyle(purple).font(.title)
                    }.frame(width: 300, height: 0) // end of hstack that has title and bookmark
                    
                    VStack{
                        Text("23/10/2024").foregroundStyle(.gray).frame(width: 300, height: 70, alignment: .leading)
                        
                        Text("this is what i wrote in my first ever journal!! yipppeee").font(.body).foregroundStyle(.white)
                        
                    } .frame(width: 300, height: 70, alignment: .leading)
                        .padding() // end of vstack that has date and journal content
                    
                } .listRowBackground(Color.red)
                    .padding()
                // end of vstack that has all the contains of the list
                    .padding()
                
                VStack{
                    
                    HStack{
                        Text("My Birthday").font(.largeTitle).foregroundStyle(purple).bold()
                        Spacer()
                        Image(systemName: "bookmark").foregroundStyle(purple).font(.title)
                    }.frame(width: 300, height: 0) // end of hstack that has title and bookmark
                    
                    VStack{
                        Text("23/10/2024").foregroundStyle(.gray).frame(width: 300, height: 70, alignment: .leading)
                        
                        Text("this is what i wrote in my first ever journal!! yipppeee").font(.body).foregroundStyle(.white)
                        
                    } .frame(width: 300, height: 70, alignment: .leading)
                        .padding() // end of vstack that has date and journal content
                    
                } .listRowBackground(Color.black)
                    .padding()
                
                // }
            } // end of list
        
            //    .scrollContentBackground(.hidden)
        }
    
    

}

#Preview {
    ViewModel()
}
