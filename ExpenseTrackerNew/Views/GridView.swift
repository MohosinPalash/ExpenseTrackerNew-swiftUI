//
//  GridView.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 19/5/23.
//

import SwiftUI

struct GridView: View {
    
    @State private var showAddExpense = false
    @State private var changeGridLayout: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink {
                        ChartView()
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                            .foregroundColor(Color.brown)
                            .padding(.horizontal)
                            .font(.largeTitle)
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        changeGridLayout.toggle()
                    } label: {
                        if changeGridLayout {
                            Image(systemName: "rectangle.grid.2x2")
                                .foregroundColor(Color.brown)
                                .padding(.horizontal)
                                .font(.largeTitle)
                        } else {
                            Image(systemName: "rectangle.grid.1x2")
                                .foregroundColor(Color.brown)
                                .padding(.horizontal)
                                .font(.largeTitle)
                        }
                    }
                }
                .padding(.vertical)
                
                TabView {
                    GridPending(changeGridLayout: $changeGridLayout)
                        .tabItem{
                            Image(systemName: "dollarsign.circle")
                            Text("Pending")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    
                    GridPaid(changeGridLayout: $changeGridLayout)
                        .tabItem{
                            Image(systemName: "dollarsign.square.fill")
                            Text("Paid")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    
                }
                .accentColor(Color.black)
                .navigationTitle("Expense Tracker")
                .safeAreaInset(edge: .bottom, alignment: .center) {
                    Button {
                        showAddExpense.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .background(Color.white)
                            .cornerRadius(25)
                            .font(.system(size:50, weight: .bold, design: .rounded))
                            .foregroundColor(Color.brown)
                            
                    }
                }
                .sheet(isPresented: $showAddExpense) {
                    CreateExpense()
                }
                Spacer()
            }
            .onAppear {
                //recurrentExpenses()
                print("Called from on Appear.")
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
