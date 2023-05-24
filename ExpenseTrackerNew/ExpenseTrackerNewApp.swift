//
//  ExpenseTrackerNewApp.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 10/5/23.
//

import SwiftUI

@main
struct ExpenseTrackerNewApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                print("background")
            case .inactive:
                print("Inactive")
            case .active:
                print("Active")
            @unknown default:
                print("Default phase")
            }
            
        }
    }
}
