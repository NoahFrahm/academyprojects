//
//  ContentView.swift
//  instagramPost
//
//  Created by Noah Frahm on 2/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        VStack{
            TopMenuView()
            
            ScrollView{
                PostView(userName: "IKEA",
                         profilePic: "IkeaLogo",
                         image: "Furniture",
                         likes: 120000,
                         caption: "sauce boss on the drip drop stimpy bong boop bop.",
                         postTime: 7)
                
                PostView(userName: "IKEA",
                         profilePic: "IkeaLogo",
                         image: "Furniture",
                         likes: 120000,
                         caption: "sauce boss on the drip drop stimpy bong boop bop.",
                         postTime: 7)
            
            }
            Spacer()
            BottomMenuView()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TopMenuView: View {
    var body: some View {
        HStack(){
            Text("Instagram")
                .bold()
                .fontWeight(.bold)
                .font(.title)
            Spacer()
            Image(systemName: "plus.square")
                .font(.title)
                .padding([.trailing, .leading], 8)
            Image(systemName: "heart")
                .font(.title)
                .padding([.trailing, .leading], 8)
            Image(systemName: "bolt.circle")
                .font(.title)
            
        }.padding([.trailing, .leading])
    }
}

struct PostView: View {
    
    var userName: String
    var profilePic: String
    var image: String
    var likes: Int
    var caption: String
    var postTime: Int
    @State private var liked: Bool = false
    
    
    var body: some View {
        VStack {
            
            
//  post bar with profile pic and user name of poster
            HStack{
//                Image("IkeaLogo")
                Image(profilePic)
                    .resizable()
                    .frame(width: 40,
                           height: 40,
                           alignment: .leading)
                    .cornerRadius(40)
//                Text("IKEA")
                Text(userName)
                    .bold()
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: "ellipsis")
                    .font(.headline)
                
                
            }
            .padding([.leading, .trailing] , 10)
            .padding([.bottom, .top], 6)
            
            
            Image(image)
                .resizable()
                .scaledToFit()
            
//    icon bar for like comment share and save
            HStack{
                
               
                Button(action: {
                    liked.toggle()
                }) {
                    Image(systemName: liked ? "heart.fill" : "heart")
                        .font(.title)
                }
                
                Image(systemName: "message")
                    .font(.title)
                
                Image(systemName: "paperplane")
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "bookmark")
                    .font(.title)
                
                
            }.padding([.top, .bottom], 8)
                .padding([.leading, .trailing] , 7)
            
            
//    like bar
            HStack{
                Image(profilePic)
                    .resizable()
                    .frame(width: 25,
                           height: 25,
                           alignment: .leading)
                    .cornerRadius(40)
                Text("Liked by")
                Text(userName)
                    .bold()
                Text("and")
                Text("\(likes) others")
                    .bold()
                
                
                Spacer()
            }
            .padding([.leading, .trailing] , 10)
            
// caption
//                 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim esse sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.//
            HStack{
            Text("**IKEA** \(caption)")
                .padding([.leading, .trailing], 10)
            Spacer()
            }
            
// comments
            HStack{
            Text("View all 3,000 comments")
                .fontWeight(.light)
                .padding([.top, .bottom], 5)
                .padding([.trailing, .leading], 10)
            
                Spacer()
                
            }
            
            HStack{
            Text("\(postTime) hours ago")
                .fontWeight(.light)
                .padding([.top, .bottom], 5)
                .padding([.trailing, .leading], 10)
            
                Spacer()
            }
        }
    }
}

struct BottomMenuView: View {
    var body: some View {
        HStack{
            Image(systemName: "house")
            Spacer()
            Image(systemName: "magnifyingglass")
            Spacer()
            Image(systemName: "play.square")
            Spacer()
            Image(systemName: "bag")
            Spacer()
            Image("IkeaLogo")
                .resizable()
                .frame(width: 25,
                       height: 25,
                       alignment: .leading)
                .cornerRadius(40)
        }.padding([.leading, .trailing], 20)
            .font(.title2)
    }
}
