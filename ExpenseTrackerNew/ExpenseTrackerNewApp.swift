//
//  ExpenseTrackerNewApp.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 10/5/23.
//

import SwiftUI

@main
struct ExpenseTrackerNewApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
