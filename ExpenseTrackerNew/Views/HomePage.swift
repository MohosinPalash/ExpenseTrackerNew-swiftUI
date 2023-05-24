//
//  HomePage.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 10/5/23.
//

import SwiftUI

struct HomePage: View {
    
    @State var isGridView: Bool = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var expenses: FetchedResults<ExpenseEntity>
    
    @State private var showAddExpense = false
    
    @State private var today: Date = Date()
    @State private var createdYear: Int = 0
    @State private var createdMonth: Int = 0
    
    @State private var currentYear: Int = 0
    @State private var currentMonth: Int = 0
    
    private let calendar: Calendar = Calendar.current
    
    var body: some View {
        
//        VStack {
//            HStack {
//                Spacer()
//
//                Button {
//                    isGridView.toggle()
//                } label: {
//                    if isGridView {
//                        Image(systemName: "rectangle.grid.2x2")
//                            .foregroundColor(Color.brown)
//                            .padding(.horizontal)
//                            .font(.title)
//                    } else {
//                        Image(systemName: "rectangle.grid.1x2")
//                            .foregroundColor(Color.brown)
//                            .padding(.horizontal)
//                            .font(.title)
//                    }
//                }
//            }
//            if isGridView {
//                GridView()
//            }else{
//                ListView()
//            }
//        }
        GridView()
        .onAppear {
            recurrentExpenses()
            print("Called from on Appear.")
        }
    }
    
    func recurrentExpenses() {
        
        for expense in expenses {
            if expense.type {
                
                let createdComponent = calendar.dateComponents([.year, .month], from: expense.updatedDate!)
                self.createdYear = createdComponent.year!
                self.createdMonth = createdComponent.month!
                
                let currentComponent = calendar.dateComponents([.year, .month], from: today)
                self.currentYear = currentComponent.year!
                self.currentMonth = currentComponent.month!
                //let ageComponenet = calendar.dateComponents([.year, .month], from: demoDate, to:expense.createdDate!)
                
                print("Created \(expense.title!): M:\(createdMonth) Y:\(createdYear)")
                print("Current \(expense.title!): M:\(currentMonth) Y:\(currentYear)")
                
                var count = 0
                if currentYear == createdYear {
                    count = currentMonth - createdMonth
                } else {
                    count = (12 - createdMonth) + ((currentYear - (createdYear+1))*12) + currentMonth
                }
                
                print("Count = \(count)")
                
                if count > 0 {
                    for _ in 1...count {
                        
                        createdMonth += 1
                        if createdMonth > 12 {
                            createdYear += 1
                            createdMonth = 1
                        }
                        print("Added for [\(createdMonth)-\(createdYear)]")
                        DataController().insertExpense(
                            title: "\(expense.title!)-[\(createdMonth)-\(createdYear)]",
                            description: expense.desc!,
                            amount: expense.amount,
                            category: expense.category!,
                            type: false,
                            status: false,
                            context: managedObjectContext)
                    }
                    DataController().updateExpense(
                        expense: expense,
                        title: "\(expense.title!)",
                        description: "\(expense.desc!)",
                        amount: expense.amount,
                        category: "\(expense.category!)",
                        type: expense.type,
                        status: true,
                        createdDate: expense.createdDate!,
                        updatedDate: Date(),
                        context: managedObjectContext)
                }
            }
        }
    }

    
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
