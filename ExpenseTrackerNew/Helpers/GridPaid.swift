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
    @State private var singleDelete: Bool = true
    //@State var selectedItems: [ExpenseEntity] = []
    @Binding var selectedItems: [ExpenseEntity]
    
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
                                    EachGrid(changeGridLayout: $changeGridLayout, selectedItems: $selectedItems, singleDelete: $singleDelete, expense: expense)
                                }
                            }
                        }
                    }
                )
            }
        }
    }
    
}

//struct GridPaid_Previews: PreviewProvider {
//    static var previews: some View {
//        GridPaid()
//    }
//}
