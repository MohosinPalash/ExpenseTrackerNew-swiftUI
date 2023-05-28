//
//  CreateExpense.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 10/5/23.


import SwiftUI

struct CreateExpense: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State var errorMessage = ""
    @State var title: String = ""
    @State var description: String = ""
    @State var amountMessage: String = ""
    @State var amount: Double = 0.0
    @State var expenseType: Bool = false
    
    @State var selectedCategory = "Select Category"
    	
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    func dismissKeyboard() {
        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
    }
    
    func validateMultiple () -> Bool {
        if textValidation(textToCheck: title) && textValidation(textToCheck: description) && textValidation(textToCheck: amountMessage) {
            return true
        }else {
            return false
        }
    }
    
    func submitData () -> Bool {
        amount = Double(amountMessage) ?? 0.0
        
        if amount > 0 {
            DataController().insertExpense(
                title: title,
                description: description,
                amount: amount,
                category: selectedCategory,
                type: expenseType,
                status: false,
                context: managedObjContext)
            dismiss()
            
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        
        VStack {
            //Dismiss Button
            Button (action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.compact.down")
                    .foregroundColor(Color.gray)
                    .font(.largeTitle)
                    .padding(.vertical)
                
            })
            
            NavigationView {
                ScrollView {
                    VStack (alignment: .leading) {
                        
                        //Title
                        Group {
                            Text("Expense Title")
                                .font(.headline)
                                .foregroundColor(Color.brown)
                                .fontWeight(.bold)
                            
                            TextField("Title of the expense", text: $title)
                                .padding()
                                .background(Color.brown.opacity(0.2).cornerRadius(10))
                                .font(.headline)
                        }
                        
                        //Description
                        Group {
                            Text("Expense Description")
                                .font(.headline)
                                .foregroundColor(Color.brown)
                                .fontWeight(.bold)
                            ZStack (alignment: .topLeading) {
                                if description.isEmpty {
                                    Text("Short Description of the expense.")
                                        .foregroundColor(Color.gray)
                                        .padding()
                                }
                                
                                TextEditor(text: $description)
                                    .frame(height: 100)
                                    .background(Color.brown.opacity(0.2))
                                    .font(.headline)
                                    .cornerRadius(10)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Button("Dismiss"){
                                                dismissKeyboard()
                                            }
                                            Button("Clear") {
                                                description = ""
                                            }
                                        }
                                    }
                            }
                            
                                
                        }
                        
                        //Amount
                        Group {
                            Text("Amount")
                                .font(.headline)
                                .foregroundColor(Color.brown)
                                .fontWeight(.bold)
                            
                            TextField("Expense Amount in Taka", text: $amountMessage)
                                .padding()
                                .background(Color.brown.opacity(0.2).cornerRadius(10))
                                .font(.headline)
                                .keyboardType(.numberPad)
                        }
                        
                        //Expense Category
                        Group {
                            HStack {
                                Text("Category")
                                    .padding(.vertical)
                                
                                Spacer()
                                
                                Menu {
                                    Button(action: {
                                        selectedCategory = "Gasoline"
                                    }, label: {
                                        Text("Gasoline")
                                    })
                                    Button(action: {
                                        selectedCategory = "Grocery"
                                    }, label: {
                                        Text("Grocery")
                                    })
                                    Button(action: {
                                        selectedCategory = "Shopping (Clothes)"
                                    }, label: {
                                        Text("Shopping (Clothes)")
                                    })
                                    Button(action: {
                                        selectedCategory = "Shopping (Cosmetics)"
                                    }, label: {
                                        Text("Shopping (Cosmetics)")
                                    })
                                    Button(action: {
                                        selectedCategory = "Shopping (Shoes)"
                                    }, label: {
                                        Text("Shopping (Shoes)")
                                    })
                                    Button(action: {
                                        selectedCategory = "Restaurant"
                                    }, label: {
                                        Text("Restaurant")
                                    })
                                } label: {
                                   Label(
                                    title: {Text(selectedCategory)},
                                    icon: {Image(systemName: "arrow.down.circle")}
                                   )
                                }
                            }
                            .foregroundColor(Color.brown)
                            .font(.headline)
                        }
                        
                        //Expense Type: recurrent or random , Keyboard dismiss,
                        Group {
                            Toggle(
                                isOn: $expenseType,
                                label: {
                                Text("Expense Type")
                                        .foregroundColor(Color.brown)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                
                            })
                            .toggleStyle(SwitchToggleStyle(tint: Color.brown))
                            .padding(.top)
                            HStack {
                                Spacer()
                                Text(expenseType ? "Recurrent" : "Random")
                                    .foregroundColor(Color.brown)
                                    .fontWeight(.bold)
                            }
                        }
                        
                        
                        //Submit Button
                        Button(action: {
                            
                            amount = Double(amountMessage) ?? 0.0
                            
                            if amount > 0 {
                                DataController().insertExpense(
                                    title: title,
                                    description: description,
                                    amount: amount,
                                    category: selectedCategory,
                                    type: expenseType,
                                    status: false,
                                    context: managedObjContext)
                                dismiss()
                            } else {
                                errorMessage = "Invalid Amount! Try again."
                            }
                            
                        }, label: {
                            Text("Submit".uppercased())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(validateMultiple() ? Color.brown : Color.gray)
                                .cornerRadius(10)
                                .font(.headline)
                                .foregroundColor(Color.white)

                        })
                        
                        Spacer()
                        
                    }
                    Spacer()
                    Text(errorMessage)
                }
                .padding(.horizontal)
                .navigationTitle("Create Expense")
            }
            
        }
        
    }
}

struct CreateExpense_Previews: PreviewProvider {
    static var previews: some View {
        CreateExpense()
    }
}
