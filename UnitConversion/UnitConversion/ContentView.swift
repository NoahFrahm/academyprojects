//
//  ContentView.swift
//  UnitConversion
//
//  Created by Noah Frahm on 2/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputVol: Double? = 0.0
    @State var from: String = "mL"
    @State var to: String = "mL"
    @FocusState private var amountIsFocused: Bool

    let units = ["mL", "Liters", "Cups", "Pints", "Gallons"]
    let conversionSnake = [0.001, 4.2267528377, 0.5, 0.125, 3785.411784]
    

    
    var output: String {
        var inputVolume = inputVol ?? 0.0
        var start: Int = 0
        var end: Int = 0
        for (index, unit) in units.enumerated() {
            if unit == from {
                start = index
            }
            if unit == to {
                end = index
            }
        }
        while start % 5 != end {
            inputVolume *= conversionSnake[start % 5]
            start += 1
        }
        return inputVolume.formatted(.number)
    }

    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{
                        TextField("Amount", value: $inputVol, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Unit", selection: $from) {
                            ForEach(units, id: \.self) {
                                Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        
                        } header: {
                            Text("Input Value and Unit")
                            .font(.subheadline)
                    }.textCase(nil)
                    Section{
                        Picker("Unit", selection: $to) {
                            ForEach(units, id: \.self) {
                                Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        
                        } header: {
                            Text("Output Unit")
                            .font(.subheadline)
                        }.textCase(nil)
                    Section{
                        Text("\(output)")
                    } header: {
                        Text("Output")
                        .font(.subheadline)
                    }.textCase(nil)
                }
            }
            .navigationTitle("Volume Conversion")
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
//            .preferredColorScheme(.dark)
    }
}
