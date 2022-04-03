//
//  ContentView.swift
//  facetime-rebuild
//
//  Created by Noah Frahm on 3/29/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showUI = false
//    @State private var dragAmount = CGSize.zero
//    @State var offset = CGPoint(x: 0, y: 0)

//    @State private var position = CGSize.zero
    @State private var position = CGPoint(x: 90, y: 0)

    
    var body: some View {
        VStack {
            if showUI {
                controlsView
                    .transition(.move(edge: .top))
            }
            
            Spacer()
                
            selfView(big: $showUI)
                .gesture(
                    DragGesture()
                    .onChanged { value in
                        self.position.x += value.location.x - value.startLocation.x
                        self.position.y += value.location.y - value.startLocation.y
                        
                        print(position.x, self.position.y)
//                        print(value.location.x, value.location.y)
                    }

                    .onEnded { p in
                        withAnimation {
//                            position.y = 100
//                            position.x = -100
//                            print(p.location.x, p.location.y)
//
                            if position.x < 0 && position.y > -380 {
                                position.y = 0
                                position.x = -130
                            }
                            if position.x > 0 && position.y > -380 {
                                position.y = 0
                                position.x = 130
                            }
                            if position.x < 0 && position.y < -380 {
                                position.y = -600
                                position.x = -130
                            }
                            if position.x > 0 && position.y < -380 {
                                position.y = -600
                                position.x = 130
                            }
                        }
                    }
                )
                .offset(x: position.x, y: position.y)
        }
        .padding(.horizontal, 8)
        .background(friendView)
        .onTapGesture {
            withAnimation{
                showUI.toggle()
            }
        }
    }
}


var friendView: some View {
    Image("forest")
        .ignoresSafeArea()
}


var controlsView: some View {
    HStack{
        VStack(alignment: .leading){
                HStack{
                    Image("forest")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading){
                        Text("Joe Doe")
                            .bold()
                            .foregroundColor(.white)
                        HStack(spacing: 2){
                            Image(systemName: "video.fill")
                            Text("FaceTime Video")
                            Image(systemName: "greaterthan")
                        }
                        .foregroundColor(Color("textgray"))
                        .font(.footnote)
                    }
                    Spacer()
                    Button(action: {}) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 50)
                                .fill(.red)
                                .frame(width: 70, height: 30)
                            Text("End")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }

                }
                Spacer()
                HStack{
                    settingButtonView(icon: "message.fill", alternate: "message.fill")
                    Spacer()

                    settingButtonView(icon: "speaker.wave.3.fill",alternate: "speaker.slash.fill")
                    Spacer()

                    settingButtonView(icon: "mic.fill",alternate: "mic.slash.fill")
                    Spacer()

                    settingButtonView(icon: "video.fill",alternate: "video.slash.fill")
                    Spacer()

                    settingButtonView(icon: "ipad.landscape",alternate: "ipad.fill")
                }
            }
            .padding([.top], 10)
            .padding([.bottom], 15)
            .padding([.leading, .trailing])
            .frame(width: 370, height: 130)
            .background(
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color("darkgray"))
                    .mask(Color.gray.opacity(0.95))
                    .foregroundColor(.gray))
    }
}


struct selfView: View {
    
    @Binding var big: Bool
    
    var body: some View {
//        HStack{
//            Spacer()
            ZStack{
                Image("desert")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                VStack{
                    Spacer()
                    if big {
                        HStack{
                            Button(action: {}) {
                                ZStack{
                                    Circle()
                                        .mask(Color.gray.opacity(0.7))
                                        .foregroundColor(.gray)
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                                        .foregroundColor(.white)
                                        .font(.title3)
                                }
                            }
                            Spacer()
                            Button(action: {}) {
                                ZStack{
                                    Circle()
                                        .mask(Color.gray.opacity(0.7))
                                        .foregroundColor(.gray)
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.white)
                                        .font(.title3)
                                }
                            }
                        }
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom])
//                        .animation(.default, value: big)
//                        .transition(.scale)
                        .transition(.scale(scale: 0.1, anchor: .bottom))
                        
                    }
//                        .transition(.scaleEffect(anchor: .bottomRight))
//                        .animation(.easeInOut
//                            .repeatForever(autoreverses: true), value: big)
//                    }
                }
            }
            .frame(width: big ? 200: 100, height: big ? 200 : 100)
//        }.transition(.scale)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct settingButtonView: View {
    
    let icon: String
    let alternate: String
    @State var selected: Bool = false
    
    var body: some View {
        Button(action: {selected.toggle()}) {
            ZStack{
                Circle()
                    .fill(selected ? .white : Color("buttongray"))
                    .frame(width: 40, height: 40)
                Image(systemName: selected ? alternate : icon)
                    .foregroundColor(selected ? .black : .white)
                    .font(.title3)
            }
            
        }
    }
}
