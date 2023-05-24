//
//  GridPaid.swift
// ExpenseTrackerNew
//
// Created by Mohosin Islam Palash on 19/5/23.

//

import SwiftUI

struct GridPaid: View {
    
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
    @State private var selectToDelete: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid (
                    columns: changeGridLayout ? columns1 : columns2,
                    alignment: .center,
                    spacing: 20,
                    content: {
                        ForEach(expenses) {expense in
                            if expense.status {
                                NavigationLink (destination: UpdateExpense( expense: expense)) {
                                    
                                    VStack {
                                        HStack{
                                            
                                            Button {
                                                selectToDelete.toggle()
                                            } label: {
                                                selectToDelete ?
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(Color.white)
                                                    .padding(.horizontal)
                                                    .font(.headline)
                                                
                                                : Image(systemName: "checkmark.circle")
                                                    .foregroundColor(Color.white)
                                                    .padding(.horizontal)
                                                    .font(.headline)
                                            }
                                            
                                            Spacer()
                                            
                                            Text(expense.title!)
                                                .font(.headline)
                                                .foregroundColor(Color.white)
                                                .multilineTextAlignment(.center)
                                            if expense.type {
                                                Image(systemName: "paperplane.circle.fill")
                                                    .foregroundColor(Color.white)
                                            }
                                            
                                            Spacer()
                                            
                                            Button {
                                                showAlert = true
                                            } label: {
                                                Image(systemName: "trash.fill")
                                                    .foregroundColor(Color.white)
                                                    .padding(.horizontal)
                                                    .font(.headline)
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
                                        .padding(.top)
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
                                            .padding(.bottom)
                                        
                                    }
                                    .frame(width: changeGridLayout ? 200 : 400, height: changeGridLayout ? 200 : 150)
                                    .background(Color.brown)
                                    .cornerRadius(20)
                                }
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

//struct GridPaid_Previews: PreviewProvider {
//    static var previews: some View {
//        GridPaid()
//    }
//}
