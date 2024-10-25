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
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .modelContainer(for: Model.self) // This makes our app listening to the model
        }
    }
}
