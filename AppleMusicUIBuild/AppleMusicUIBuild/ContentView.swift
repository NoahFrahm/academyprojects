//
//  ContentView.swift
//  AppleMusicUIBuild
//
//  Created by Noah Frahm on 2/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var pause: Bool = true
    @State private var volume: Double = 0.0
    
    var body: some View {
        ZStack{
            BackgroundView()
            VStack {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                Image("glass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250, alignment: .center)
                    .cornerRadius(10)
                    .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.33),
                            radius: 30, x: 0, y:30)
                Spacer()
                SongInfoView()
                SliderView(pause: $pause)
                    .padding([.leading, .trailing], 30)
//                PlayPauseView(pause: $pause)
//                    .padding([.top, .bottom], 20)
//                Spacer()
                VolumeView(volume: $volume)
                    .padding([.top, .bottom], 20)
                
                HStack{
                    Image(systemName: "text.quote")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "airplayaudio")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "list.bullet")
                        .font(.title2)
                        .foregroundColor(.white)

                }.padding([.leading, .trailing], 100)
//                Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("purp"),Color("pink"), Color("purp")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
            .ignoresSafeArea()
    }
}

struct SliderView: View {
    
    var duration: Double = 328
    @Binding var pause: Bool
    @State private var time: Double = 0.0
    
//    @objc func tick(){
//        time += 1
//    }
    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()

    var body: some View {
        
 

        
        let min: Int = Int(time) / 60
        let tenths: Int = Int(time) % 60 / 10
        let singles: Int = Int(time) % 60 % 10
        
        let timeLeft: Int = Int(duration) - Int(time)
        let mintot: Int = Int(timeLeft) / 60
        let tenthstot: Int = Int(timeLeft) % 60 / 10
        let singlestot: Int = Int(timeLeft) % 60 % 10
        
        VStack {
            
            Slider(value: $time, in: 0...duration)
                .accentColor(Color.white)
                .onReceive(timer, perform: {
                    output in
                    if (!pause && time < duration) {time += 0.001}
                })
            
            HStack{
                Text("\(min):\(tenths)\(singles)")
                    .foregroundColor(.white)
                Spacer()
                Text("-\(mintot):\(tenthstot)\(singlestot)")
                    .foregroundColor(.white)
            }
            HStack{
                Image(systemName: "backward.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                Spacer()
                Button{
                    pause.toggle()
                } label: {
                    Image(systemName: pause ? "play.fill": "pause.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }.frame(width: 100, height: 60, alignment: .center)
                Spacer()
                Image(systemName: "forward.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                
            }.padding([.leading, .trailing], 50)
                .padding([.top, .bottom], 10)
                
        }
    }
}

struct SongInfoView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 1){
                Text("Helium")
                    .bold()
                    .foregroundColor(.white)
                    .font(.title2)
                Text("Glass Animals")
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .font(.title3)
                
                
            }
            Spacer()
            Image(systemName: "ellipsis.circle.fill")
                .foregroundColor(.white)
                .font(.title2)
            
        }.padding([.leading, .trailing], 30)
    }
}

struct PlayPauseView: View {
    
    @Binding var pause: Bool
    
    var body: some View {
        HStack{
            Image(systemName: "backward.fill")
                .font(.system(size: 35))
                .foregroundColor(.white)
            Spacer()
            Button{
                pause.toggle()
            } label: {
                Image(systemName: pause ? "play.fill": "pause.fill")
                    .font(.system(size: 60))
//                    .frame(width: 10, height: 10, alignment: .center)
                    .foregroundColor(.white)
            }
//            .frame(width: 10, height: 10, alignment: .center)
//            Image(systemName: "forward.fill")
            Spacer()
            Image(systemName: "forward.fill")
                .font(.system(size: 35))
                .foregroundColor(.white)
            
        }
//        .frame(width: 10, height: 10, alignment: .center)
        .padding([.leading, .trailing], 70)
        
    }
}

struct VolumeView: View {
    
    @Binding var volume: Double
    
    var body: some View {
        HStack{
            Image(systemName: "volume.fill")
                .font(.subheadline)
                .foregroundColor(.white)
            Slider(value: $volume, in: 0...100)
                .accentColor(Color.white)
            Image(systemName: "speaker.wave.3.fill")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding([.leading, .trailing], 30)
    }
}
