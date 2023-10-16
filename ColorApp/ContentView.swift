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
                    .frame(width: 320, height: 180)
                    .clipShape(.rect(cornerRadius: 30))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .padding(.bottom, 30)
                
                ColorSlideView(value: $redSliderValue, color: .red)
                ColorSlideView(value: $greenSliderValue, color: .green)
                ColorSlideView(value: $blueSliderValue, color: .blue)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

struct ColorSlideView: View {
    @Binding var value: Double
    var color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .frame(width: 40)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
        }
    }
}
