//
//  BulkDataInsert.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 27/5/23.
//

import SwiftUI

struct BulkDataInsert: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)]) var expenses: FetchedResults<ExpenseEntity>
    
    
    var body: some View {
        Button(action: {
            insertBulkData()
        }, label: {
            Text("Insert Data")
                .frame(width: 100, height: 40)
                .background(Color.brown)
                .foregroundColor(Color.white)
                .cornerRadius(10)
        })
    }
    
    func getDate(givenDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: givenDate) // replace Date String
    }
    
    func insertBulkData() {
        var month = 0
        var year = 2020
        var crDate: Date
        for i in 1..<42 {
            month = month + 1
            if month > 12 {
                month = 1
                year = year + 1
            }
            
            let randomDouble = Double.random(in: 500...2000)
            let randomDate = Int.random(in: 1...25)
            if month > 9 {
                crDate = getDate(givenDate: "\(year)-\(month)-\(randomDate)T11:42:00") ?? Date()
            } else {
                crDate = getDate(givenDate: "\(year)-0\(month)-\(randomDate)T11:42:00") ?? Date()
            }
            
            DataController().insertBulkExpense(
                title: "Title - \(i)",
                description: "Description - \(10+i)",
                amount: randomDouble,
                category: "Demo",
                type: false,
                status: true,
                createdDate: crDate,
                paymentDate: crDate,
                updatedDate: crDate,
                context: managedObjectContext)
            
            print("\(i) - Tk.\(Int(randomDouble)) is inserted")
        }
    }
}

struct BulkDataInsert_Previews: PreviewProvider {
    static var previews: some View {
        BulkDataInsert()
    }
}
