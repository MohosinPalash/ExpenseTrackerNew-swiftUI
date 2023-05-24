//
//  PendingExpenses.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 14/5/23.
//

import SwiftUI

struct PendingExpenses: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var expenses: FetchedResults<ExpenseEntity>
    @State private var showAlert: Bool = false
    
    
    var body: some View {
        VStack {
            List {
                ForEach(expenses) { expense in
                    if !expense.status {
                        NavigationLink(destination: UpdateExpense(expense: expense)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack{
                                        //square.and.pencil.circle.fill
                                        Text(expense.title!)
                                            .font(.headline)
                                        if expense.type {
                                            Image(systemName: "paperplane.circle.fill")
                                                .foregroundColor(Color.black)
                                        }
                                    }
                                    Text(expense.desc!)
                                        .font(.subheadline)
                                    Text(expense.category!)
                                        .font(.subheadline)
                                    Text(expense.createdDate!.formatted())
                                        .font(.subheadline)
                                }
                                
                                Spacer()
                                
                                Text("\(Int(expense.amount))")
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                        }
                        .swipeActions (edge: .trailing) {
                            
                            Button("Delete") {
                                showAlert = true
                            }
                            .background(Color.red)
                        }
                        .alert(isPresented: $showAlert, content: {
                            Alert(
                                title: Text("Are you sure to delete?"),
                                message: Text("Delete \(expense.title!)"),
                                primaryButton: .destructive(Text("Delete"), action: {
                                    deleteExpense(expense: expense)
                                }),
                                secondaryButton: .cancel()
                            )
                        })
                    }
                }
            }
            .listStyle(.plain)
        }
    }
    
    private func deleteExpense(expense: ExpenseEntity) {
        withAnimation {
            
            managedObjectContext.delete(expense)

            DataController().save(context: managedObjectContext)
            print("Specific data successfully!")
        }
    }
}

struct PendingExpenses_Previews: PreviewProvider {
    static var previews: some View {
        PendingExpenses()
    }
}
