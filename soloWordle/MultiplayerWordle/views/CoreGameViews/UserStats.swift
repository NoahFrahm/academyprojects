//
//  UserStats.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/13/22.
//

import SwiftUI

struct UserStats: View {
    
//    fetch this frequncy data from db
    @State var frequency: [Int] = [1, 2, 3, 2, 1, 0]
    @Binding var resetContinue: Bool
    
    var barLength: Double = 400
    var sumGuesses: Double {
        var total = 0.0
        for num in frequency {
            total += Double(num)
        }
        return total
    }
    var ratios: [Double] {
        var ratis: [Double] = []
        for freq in frequency{
            ratis.append(Double(freq) / sumGuesses)
        }
        return ratis
    }
    
    var fillin: Color = .white
    var buttonFill: Color = .white
    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Button(action: {resetContinue = false}) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
            HStack{
                Spacer()
                Text("**Guess Distribution**")
                    .font(.title2)
                Spacer()
            }
            
            ForEach(0...(frequency.count - 1), id: \.self) { index in
                HStack{
                    Text("\(index + 1)")
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: 1 + barLength * ratios[index] , height: 50, alignment: .center)
                    Text("\(frequency[index])")
                }
            }.padding([.leading, .trailing])
            
            HStack{
                Spacer()
                Button(action: {resetContinue = false}) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(buttonFill)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.black, lineWidth: 2))
                            .frame(width: 150, height: 50, alignment: .center)

                        Text("Continue")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                }
                Button(action: {resetContinue = false}) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(buttonFill)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.black, lineWidth: 2))
                            .frame(width: 150, height: 50, alignment: .center)

                        Text("Quit")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                }
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(fillin)
            )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(.black, lineWidth: 2)
            )
        .padding()
        .frame(width: 400, height: 200)
    }
}

struct UserStats_Previews: PreviewProvider {
    static var previews: some View {
        UserStats(resetContinue: .constant(false))
    }
}
