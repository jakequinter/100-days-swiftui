//
//  ContentView.swift
//  Challenege1
//
//  Created by Jake Quinter on 6/18/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemp: Double = 0;
    @State private var startingMeasurement = "F"
    @State private var endingMeasurement = "C"
    
    let measurements = ["F", "C", "K"]
    
    var convertedTemp: Double {
        if (startingMeasurement == endingMeasurement) {
            return inputTemp
        }
        
        if (startingMeasurement == "F") {
            return convertFahrenheit()
        }
        
        if (startingMeasurement == "C") {
            return convertCelsius()
        }
        
        return convertKelvin()
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("Enter your temperature", value: $inputTemp, format: .number)
                        
                        Picker("", selection: $startingMeasurement) {
                            ForEach(measurements, id: \.self) {
                                        Text("°\($0)")
                                    }
                        }
                    }
                }
                
                Section {
                    HStack {
                        Text(convertedTemp, format: .number)
                        
                        Picker("", selection: $endingMeasurement) {
                            ForEach(measurements, id: \.self) {
                                        Text("°\($0)")
                                    }
                        }
                    }
                }
            }
            .navigationTitle("Temp Converter")
        }
    }
    
    func convertFahrenheit() -> Double {
        if (startingMeasurement == "F" && endingMeasurement == "C") {
            return convertFahrenheitToCelsius()
        }
        
        return convertFahrenheitToKelvin()
    }
    
    func convertCelsius() -> Double {
        if (startingMeasurement == "C" && endingMeasurement == "F") {
            return convertCelsiusToFahrenheit()
        }
        
        return convertCelsiusToKelvin()
    }
    
    func convertKelvin() -> Double {
        if (startingMeasurement == "K" && endingMeasurement == "F") {
            return convertKelvinToFahrenheit()
        }
        
        return convertKelvinToCelsius()
    }
    
    func convertKelvinToFahrenheit() -> Double {
        return (inputTemp - 273.15) * 9/5 + 32
    }
    
    func convertKelvinToCelsius() -> Double {
        return inputTemp - 273.15
    }
    
    func convertCelsiusToFahrenheit() -> Double {
        return (inputTemp * 9/5) + 32
    }
    
    func convertCelsiusToKelvin() -> Double {
        return inputTemp + 273.15
    }
    
    func convertFahrenheitToCelsius() -> Double {
        return (inputTemp - 32) * 5/9
    }
    
    func convertFahrenheitToKelvin() -> Double {
        return (inputTemp - 32) * 5/9 + 273.15
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
