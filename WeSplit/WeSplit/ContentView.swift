//
//  ContentView.swift
//  WeSplit
//
//  Created by Jake Quinter on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var totalPerPerson: Double {
        let personCount = Double(numberOfPeople + 2);
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount / 100) * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal / personCount
    }
    
    var totalCheckAmount: Double {
        let personCount = Double(numberOfPeople + 2);
        return totalPerPerson * personCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter the check amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                }
                
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: currencyFormatter)
                }
                
                Section("Check total") {
                    Text(totalCheckAmount, format: currencyFormatter)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
