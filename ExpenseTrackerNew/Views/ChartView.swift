//
//  ChartView.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 18/1/24.
//
// Insert data 

import SwiftUI

struct TimeData: Identifiable {
    var id = UUID()
    var values: [CGFloat]
}
struct ChartView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.createdDate)],
        predicate: NSPredicate(format: "status == 1")
    ) var expenses: FetchedResults<ExpenseEntity>
    
    @State var pickerSelectedItem = 0
    @State var listTitle: Int = 2020
    @State var dataPoints: [TimeData] = [
        TimeData(values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    ]
    @Binding var pickerList: [String]
    @State var years: [Int] = []
    
    func normalize (selectedArray: [CGFloat]) -> [CGFloat] {
        print(selectedArray)
        var minElement: CGFloat = selectedArray.min() ?? 0.0
        var maxElement: CGFloat = selectedArray.max() ?? 200.0
        print(minElement)
        let result = selectedArray.map { ( ( ($0 - minElement) / (maxElement - minElement) ) + 0.01 )*200}
        print(result)
        return result
    }
    
    func getYear(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        return components.year ?? 0
    }
    
    func getMonth(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        return components.month ?? 0
    }
    
    func getDataPoints() {
        //var years: [Int] = []
        var tempData: [CGFloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        var prevYear: Int = getYear(date: expenses[0].createdDate ?? Date())
        var prevMonth: Int = getMonth(date: expenses[0].createdDate ?? Date())
        var sum: Double = 0.0
        for expense in expenses {
            let currentYear: Int = getYear(date: expense.createdDate ?? Date())
            let currentMonth: Int = getMonth(date: expense.createdDate ?? Date())
            
            if prevYear == currentYear {
                
                if prevMonth == currentMonth {
                    sum += expense.amount
                } else {
                    tempData[prevMonth-1] = sum
                    sum = expense.amount
                    prevMonth = currentMonth
                }
            } else {
                years.append(prevYear)
                
                tempData[prevMonth-1] = sum
                sum = expense.amount
                prevMonth = currentMonth
                prevYear = currentYear
                print(years)
                //print(tempData)
                dataPoints.append(TimeData(values: tempData))
                tempData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            }
            
        }
        tempData[prevMonth-1] = sum
        years.append(prevYear)
        
        print(years)
        //print(tempData)
        dataPoints.append(TimeData(values: tempData))
    }
    
    var month: [String] = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    
    var body: some View {
        
        ZStack {
            Color.brown.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Chart View")
                    .font(.largeTitle)
                    .foregroundColor(.brown)
                    .fontWeight(.bold)
                
                Text("\(pickerList.count)")
                

                Picker(selection: $pickerSelectedItem, label: Text("").foregroundColor(Color.brown)) {
//                    ForEach(0..<pickerList.count) { index in
//                        Text(pickerList[index]).tag(index)
//                    }
                    ForEach(pickerList.indices) { i in
                        Text(pickerList[i]).tag(i)
                    }
//                    ForEach(pickerList, id:\.self) { x in
//                        let index = pickerList.firstIndex(of: x)
//                        Text(x).onTapGesture {
//                            pickerSelectedItem = index ?? 0
//                        }
//                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal, 24)
                .foregroundColor(.white)
                .onChange(of: pickerSelectedItem) { tag in
                    print(dataPoints[pickerSelectedItem].values)
                    listTitle = 2020 + pickerSelectedItem
                }
                ScrollView(.horizontal) {
                    HStack (spacing: 10) {
                        ForEach (0..<12) { index in
                            if pickerSelectedItem == 0 {
                                BarView(value: dataPoints[pickerSelectedItem].values[index], month: month[index])
                            } else {
                                BarView(value: normalize(selectedArray: dataPoints[pickerSelectedItem].values)[index], month: month[index])
                            }
//                            BarView(value: dataPoints[pickerSelectedItem].values[index], month: month[index])
                        }
                    }
                    .padding()
                }
                .padding(.top, 24)
                .animation(.default)
                
                Text(pickerList[pickerSelectedItem])
                    .font(.largeTitle)
                    .foregroundColor(.brown)
                    .fontWeight(.bold)
                
                List {
                    HStack {
                        Text("Month")
                        Spacer()
                        Text("Amount")
                    }
                    ForEach (0..<12) { index in
                        HStack {
                            Text("\(month[index]) - \(String(2020 + pickerSelectedItem))")
                            Spacer()
                            Text("\(Int(dataPoints[pickerSelectedItem].values[index]))")
                        }
                        .foregroundColor(.white)
                    }
                    .listRowBackground(Color.brown)
                }
                .background(.brown)
                .listStyle(.plain)
                .padding(.horizontal)
                Spacer()
            }
            
        }
        .onAppear {
            getDataPoints()
            for i in 0..<years.count {
                pickerList.append(String(years[i]))
            }
            print(pickerList)
        }.onDisappear {
            pickerList.removeSubrange(5..<pickerList.count)
        }
    }
}
struct BarView: View {
    
    var value: CGFloat
    var month: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width: 50, height: 200)
                    .foregroundColor(.brown.opacity(0))
                Capsule().frame(width: 40, height: value)
                    .foregroundColor(.brown)
            }
            Text(month)
                .foregroundColor(.black)
                .padding(.top, 8)
        }
    }
}
//
//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
