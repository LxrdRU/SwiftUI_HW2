//
//  ContentView.swift
//  SwiftUI_HW2
//
//  Created by Andrey Markov on 2020-12-15.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = 125.0
    @State private var greenSliderValue = 125.0
    @State private var blueSliderValue = 125.0
    let multiplier = 0.00392157
    @State var alert = false
    var body: some View {
        VStack{
            Color(red: redSliderValue * multiplier, green: greenSliderValue * multiplier, blue: blueSliderValue * multiplier)
                .frame(width: 300, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 4)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black))
                
            VStack {
                ColorSlider(value: $redSliderValue, col: .red, showAlert: alert)
                ColorSlider(value: $greenSliderValue, col: .green, showAlert: alert)
                ColorSlider(value: $blueSliderValue, col: .blue, showAlert: alert)
            }}
    }
}

struct ColorSlider: View{
    @Binding var value: Double
    var col: Color
    @State var showAlert: Bool
    
    
    var body: some View {
        HStack{
            Text("\(String(format:"%.f", value))")
                .padding(5)
            Slider(value: $value, in: 0...255)
                .accentColor(col)
            TextField("", value: $value, formatter: NumberFormatter(), onCommit:  {
                checkValue()
            })
                .frame(width: 35, height: 35, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black))
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Incorrect input data"), message: Text("Please enter number"))
            })
                .padding(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension ColorSlider{
    private func checkValue(){
        if  !(0...255).contains(value){
            value = 0
            showAlert = true
        }
    }
}
