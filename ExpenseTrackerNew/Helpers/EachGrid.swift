//
//  EachGrid.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 24/5/23.
//

import SwiftUI

struct EachGrid: View {
    @Binding var changeGridLayout: Bool
    @State private var showAlert: Bool = false
    @State private var selectToDelete: Bool = false
    @Binding var selectedItems: [ExpenseEntity]
    @Binding var singleDelete: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var expense: ExpenseEntity
    var body: some View {
        VStack {
            HStack{
                
                Button {
                    selectToDelete.toggle()
                    if selectToDelete {
                        selectedItems.append(expense)
                    } else {
                        selectedItems = selectedItems.filter { $0 != expense }
                    }
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
                
                Text(expense.title ?? "")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                if expense.type {
                    Image(systemName: "paperplane.circle.fill")
                        .foregroundColor(Color.white)
                }
                
                Spacer()
                
                Button {
                    if selectedItems.count == 0 {
                        showAlert = true
                    }
                } label: {
                    Image(systemName: "trash.fill")
                        .foregroundColor(selectedItems.count > 0 ? Color.brown : Color.white)
                        .padding(.horizontal)
                        .font(.headline)
                }
                .alert(isPresented: $showAlert, content: {
                    Alert(
                        title: Text("Are you sure to delete?"),
                        message: Text("Delete \(expense.title!)"),
                        primaryButton: .destructive(Text("Delete"), action: {
                            DataController().deleteExpense(expense: expense, context: managedObjectContext)
                        }),
                        secondaryButton: .cancel()
                    )
                })
            }
            .padding(.top)
            Text(expense.category ?? "")
                .foregroundColor(Color.white)
            Text(expense.createdDate?.formatted() ?? Date().formatted())
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
//    private func deleteExpense(expense: ExpenseEntity) {
//        withAnimation {
//            
//            managedObjectContext.delete(expense)
//
//            DataController().save(context: managedObjectContext)
//            print("Specific data successfully!")
//        }
//    }
}

//struct EachGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        EachGrid()
//    }
//}
