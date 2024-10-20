//
//  ContentView.swift
//  Journali
//
//  Created by Yomna Eisa on 20/10/2024.
//


// Slash screen for Journali App

import SwiftUI

struct SplashScreenView: View {
    
    var body: some View {

    ZStack {
    
    Color.black.edgesIgnoringSafeArea(.all)
            
            LinearGradient(gradient: Gradient(colors: [Color(red: 88 / 255, green: 86 / 255, blue: 215 / 255).opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Icon").imageScale(.large)
                
                Text("Journali").font(.largeTitle).bold().foregroundStyle(Color.white)

                Text("Your thoughts, your story").foregroundStyle(Color.white)

            } // End of VStack
        } // End of ZStack
    } // End of body
} // End of ContentView

#Preview {
    SplashScreenView()
}
