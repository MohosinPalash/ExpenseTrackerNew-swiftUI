//
//  HomePage.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 10/5/23.
//

import SwiftUI

struct HomePage: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var expenses: FetchedResults<ExpenseEntity>
    
    var body: some View {
        //Text("No of expenses: \(expenses.count)")
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink ("Add Expense", destination: CreateExpense())
                        .padding(.trailing)
                        .font(.subheadline)
                        .foregroundColor(Color.brown)
                }
                List {
                    ForEach(expenses) { expense in
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(expense.title!)
                                    .font(.headline)
                                Text(expense.desc!)
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            Text("\(Int(expense.amount))")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                }
                
            }
            .navigationTitle("Expense Tracker")
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
