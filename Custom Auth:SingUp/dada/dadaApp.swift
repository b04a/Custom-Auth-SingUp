//
//  dadaApp.swift
//  dada
//
//  Created by Danil Bochkarev on 29.09.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

@main
struct dadaApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
