//
//  ContentView.swift
//  ColorApp
//
//  Created by Екатерина Теляубердина on 16.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var redTFValue = ""
    @State private var greenTFValue = ""
    @State private var blueTFValue = ""
    
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Color
                .gray
                .ignoresSafeArea()
                .opacity(0.3)
            
            VStack {
                Color(
                    red: redSliderValue / 255,
                    green: greenSliderValue / 255,
                    blue: blueSliderValue / 255
                )
                .configueColorView()
                
                ColorSlideStackView(
                    value: $redSliderValue,
                    textValue: $redTFValue,
                    color: .red)
                
                ColorSlideStackView(
                    value: $greenSliderValue,
                    textValue: $greenTFValue,
                    color: .green
                )
                
                ColorSlideStackView(
                    value: $blueSliderValue,
                    textValue: $blueTFValue,
                    color: .blue
                )
                
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack{
                            Spacer()
                            
                            Button("Done") {
                                getSliderValue(from: &redTFValue, to: &redSliderValue)
                                getSliderValue(from: &greenTFValue, to: &greenSliderValue)
                                getSliderValue(from: &blueTFValue, to: &blueSliderValue)
                                
                                hideKeyboard()
                            }
                            
                            .alert("Input out of range", isPresented: $isPresented, actions: {}) {
                                Text("Please enter a number from 0 to 255")
                            }
                            .onTapGesture {
                                hideKeyboard()
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func checkInput(text: String) -> Bool {
        if let inputText = Double(text), (0...255).contains(inputText) {
            return true
        } else {
            isPresented.toggle()
            return false
        }
    }
    
    private func getSliderValue(from text: inout String, to value: inout Double) {
        if checkInput(text: text) {
            value = Double(text) ?? 0
        } else {
            text = "\(lround(value))"
        }
    }
}


#Preview {
    ContentView()
}

struct ColorSlideStackView: View {
    @Binding var value: Double
    @Binding var textValue: String
    var color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .frame(width: 40)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .animation(.easeInOut(duration: 2.0), value: value)
            TextField("0", text: $textValue)
                .frame(width: 50)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .onAppear {
                    textValue = "\(lround(value))"
                }
                .onChange(of: value) {
                    textValue = "\(lround(value))"
                }
        }
    }
}

struct ColorViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 320, height: 180)
            .clipShape(.rect(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white, lineWidth: 5)
            )
            .padding(.bottom, 30)
            .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

extension Color {
    func configueColorView() -> some View {
        modifier(ColorViewModifier())
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
