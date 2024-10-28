//
//  JournaliApp.swift
//  Journali
//
//  Created by Yomna Eisa on 20/10/2024.
//

import SwiftUI
import SwiftData

@main
struct JournaliApp: App {
   // @StateObject private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
// .environmentObject(viewModel)
                .modelContainer(for: Journal.self) // This makes our app listening to the model
                .preferredColorScheme(.dark)
        }
    }
}
