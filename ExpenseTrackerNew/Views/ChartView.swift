//
//  ChartView.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 18/1/24.
//
// Insert data 

import SwiftUI


import SwiftUI
//import Charts
struct TimeData: Identifiable {
    var id = UUID()
    var values: [CGFloat]
}
struct ChartView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.createdDate, order: .reverse)],
        predicate: NSPredicate(format: "status == 1")
    ) var expenses: FetchedResults<ExpenseEntity>
    
    @State var pickerSelectedItem = 0
    @State var listTitle: Int = 2020
    @State var dataPoints: [TimeData] = [
        TimeData(values: [150, 80, 30, 35, 65, 130, 45, 155, 190, 120, 100, 200]),
//        TimeData(values: [35, 65, 130, 45, 155, 190, 120, 100, 200, 120, 90, 40])
//        TimeData(values: [120, 100, 200, 120, 90, 40, 35, 65, 130, 45, 155, 190])
    ]
    
    func normalize (selectedArray: [CGFloat]) -> [CGFloat] {
        let minElement: CGFloat = selectedArray.min() ?? 0.0
        let maxElement: CGFloat = selectedArray.max() ?? 0.0
        print(minElement)
        let result = selectedArray.map { ($0 - minElement) / (maxElement - minElement)}
        print(result)
        return result
    }
    
    var month: [String] = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    
    
    var body: some View {
        
        ZStack {
            Color.brown.opacity(0.5).edgesIgnoringSafeArea(.all)
            VStack {
                
                Text("Chart View")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                //Dropdown
                Picker(selection: $pickerSelectedItem, label: Text("")) {
                    Text("2020").tag(0)
                    Text("2021").tag(1)
                    Text("2022").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 24)
                .foregroundColor(.white)
                .onChange(of: pickerSelectedItem) { tag in
                    //print(expenses)
                    listTitle = 2020 + pickerSelectedItem
                }
                ScrollView(.horizontal) {
                    HStack (spacing: 10) {
                        ForEach (0..<12) { index in
                            BarView(value: dataPoints[pickerSelectedItem].values[index], month: month[index])
                        }
                    }
                    .padding()
                }
                
                .padding(.top, 24)
                .animation(.default)
                
                Text(String(listTitle))
                    .font(.largeTitle)
                    .foregroundColor(.white)
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
        .onAppear{
            dataPoints.append(TimeData(values: [35, 65, 130, 45, 155, 190, 120, 100, 200, 120, 90, 40]))
            dataPoints.append(TimeData(values: [15, 25, 26, 68,0,0,0,15,0,0,0,0]))
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
                    .foregroundColor(.white)
            }
            Text(month)
                .foregroundColor(.black)
                .padding(.top, 8)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
