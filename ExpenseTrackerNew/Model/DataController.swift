//
//  DataController.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 10/5/23.
// Multiple Delete Button
// External Liabrary
// External dependency

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
        expense.updatedDate = Date()
        
        save(context: context)
        print("Date inserted succesfully!")
    }
    
    //Insert Bulk Expenses
    func insertBulkExpense (title: String, description: String, amount: Double, category: String, type: Bool, status: Bool, context: NSManagedObjectContext) {
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
        expense.updatedDate = Date()
        
        save(context: context)
        print("Date inserted succesfully!")
    }
    
    
    //Update Operation
    func updateExpense(expense: ExpenseEntity,title: String, description: String, amount: Double, category: String, type: Bool, status: Bool, createdDate: Date, updatedDate: Date, context: NSManagedObjectContext) {
        
        expense.title = title
        expense.desc = description
        expense.amount = amount
        expense.category = category
        expense.type = type
        expense.status = status
        expense.createdDate = createdDate
        expense.paymentDate = Date()
        expense.updatedDate = updatedDate
        
        save(context: context)
    }
    
    func deleteExpense(expense: ExpenseEntity, context: NSManagedObjectContext) {
        context.delete(expense)
        save(context: context)
        print("Specific data successfully!")
    }
    
    func deleteMultipleExpenses(selectedItems: [ExpenseEntity], context: NSManagedObjectContext) {
        for expense in selectedItems {
            context.delete(expense)
            save(context: context)
            //context.refreshAllObjects()
        }
        print("Specific data successfully!")
    }
}
