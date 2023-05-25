//
//  GridPending.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 19/5/23.

import SwiftUI

struct GridPending: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var expenses: FetchedResults<ExpenseEntity>
    
    let columns1: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    let columns2: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    @Binding var changeGridLayout: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid (
                    columns: changeGridLayout ? columns1 : columns2,
                    alignment: .center,
                    spacing: 20,
                    content: {
                        ForEach(expenses) {expense in
                            if !expense.status {
                                NavigationLink (destination: UpdateExpense( expense: expense)) {
                                    
                                    VStack {
                                        HStack{
                                            Text(expense.title!)
                                                .font(.headline)
                                                .foregroundColor(Color.white)
                                                .padding(.top)
                                                .multilineTextAlignment(.center)
                                            if expense.type {
                                                Image(systemName: "paperplane.circle.fill")
                                                    .foregroundColor(Color.white)
                                                    .padding(.top)
                                            }
                                        }
                                        if changeGridLayout {
                                            Text(expense.desc!)
                                                .foregroundColor(Color.white)
                                                .font(.headline)
                                        }
                                        Text(expense.category!)
                                            .foregroundColor(Color.white)
                                        Text(expense.createdDate!.formatted())
                                            .foregroundColor(Color.white)
                                        
                                        Spacer()
                                        
                                        Text("TK. \(Int(expense.amount))")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .frame(width: changeGridLayout ? 180 : 380, height: 40)
                                            .background(Color.white)
                                            .foregroundColor(Color.brown)
                                            .cornerRadius(10)
                                            .padding(.vertical)
                                        
                                    }
                                    .frame(width: changeGridLayout ? 200 : 400, height: changeGridLayout ? 180 : 140)
                                    .background(Color.brown)
                                    .cornerRadius(20)
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
                )
            }
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

//struct GridPending_Previews: PreviewProvider {
//    static var previews: some View {
//        GridPending()
//    }
//}
