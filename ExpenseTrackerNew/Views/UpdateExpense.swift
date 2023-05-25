//
//  UpdateExpense.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 12/5/23.
//

import SwiftUI

struct UpdateExpense: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    var expense: FetchedResults<ExpenseEntity>.Element
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                    .padding(.leading)
                    .font(.title)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                Spacer()
            }
            
            VStack {
                HStack{
                    Text(expense.title!)
                        .font(.title)
                        .fontWeight(.bold)
                    if expense.type {
                        Image(systemName: "paperplane.circle.fill")
                    }
                }
                .padding()
                VStack {
                    Spacer()
                    Text("Expense Amount")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    
                    Text("TK. \(Int(expense.amount))")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                    
                }
                .frame(width: 350, height: 150)
                .background(Color.brown)
                .cornerRadius(25)
                Group{
                    Text(expense.desc!)
                        .font(.headline)
                    Text(expense.category!)
                        .font(.headline)
                    Text("Date of cration: \(expense.createdDate!.formatted())")
                        .font(.subheadline)
                }
                .padding(.vertical)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 500)
            .background(Color.blue.opacity(0.4))
            .cornerRadius(25)
            .padding()
            
            if expense.status {
                Text("This is a paid expense")
            } else {
                Spacer()
                Button("Pay Expense") {
                    DataController().updateExpense(
                        expense: expense,
                        title: "\(expense.title!)",
                        description: "\(expense.desc!)",
                        amount: expense.amount,
                        category: "\(expense.category!)",
                        type: expense.type,
                        status: true,
                        createdDate: expense.createdDate!,
                        updatedDate: expense.updatedDate ?? Date(),
                        context: managedObjContext)
                    dismiss()
                }
                .frame(width: 200, height: 50)
                .background(Color.brown)
                .foregroundColor(Color.white)
                .font(.headline)
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        
        
    }
}

//struct UpdateExpense_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateExpense()
//    }
//}
