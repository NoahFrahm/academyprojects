//
//  ContentView.swift
//  CustomerCounter
//
//  Created by Noah Frahm on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    @State var colorVals: [Double] = [0.0,0.0,0.0]
    @State var people: Int = 0
//    @State var rgbColor = Color(red: 0.0, green: 1.0, blue: 1.5)
    let increments: [Double] = [0.1, 0.2, 0.3]
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(red: colorVals[0], green: colorVals[1], blue: colorVals[2])], startPoint: .leading, endPoint: .trailing).ignoresSafeArea()
            VStack{
            HStack{
           
            Text("\(people) people")
                .padding()
                .foregroundColor(.white)
                .font(.system(size: 60))
            Spacer()
            Image(systemName: "gear")
                    .foregroundColor(.white)
                    .font(.system(size: 50))

            }.padding([.leading, .trailing], 10)
                    .padding([.top, .bottom],5)
            Spacer()
                
            HStack{
                Button{
                    if people > 0{
                        people -= 1
                        for i in 0...2 {
                            colorVals[i] = Double((colorVals[i] + increments[i]))
                        }
                    }
                } label: {
                    Image(systemName: "minus")
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                }
                Spacer()
                Button{
                    people += 1
                    for i in 0...2 {
                        colorVals[i] = Double(colorVals[i] + increments[i])
                    }
                
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                }
            }.padding([.leading, .trailing], 30)

            
            }
            
        }
//        .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
