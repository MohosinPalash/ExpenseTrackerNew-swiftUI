//
//  DataController.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 10/5/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Expense")
    
    init() {
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core Data \(error)")
            } else {
                print("Successfully fetched core data")
            }
            
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data is saved successfully.")
        } catch {
            print("Data is not saved.")
        }
    }
    
    //Insert Operation
    func insertExpense (title: String, description: String, amount: Double, category: String, type: Bool, status: Bool, context: NSManagedObjectContext) {
        let expense = ExpenseEntity(context: context)
        
        expense.id = UUID()
        expense.title = title
        expense.desc = description
        expense.amount = amount
        expense.category = category
        expense.type = type
        expense.status = status
        expense.createdDate = Date()
        expense.paymentDate = Date()
        
        save(context: context)
    }
    
    //Update Operation
    func updateExpense(expense: ExpenseEntity,title: String, description: String, amount: Double, category: String, type: Bool, status: Bool, createdDate: Date, context: NSManagedObjectContext) {
        
        expense.title = title
        expense.desc = description
        expense.amount = amount
        expense.category = category
        expense.type = type
        expense.status = status
        expense.createdDate = createdDate
        expense.paymentDate = Date()
        
        save(context: context)
    }
}
