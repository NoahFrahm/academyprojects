//
//  BusinessView.swift
//  p01
//
//  Created by Samuel Shi on 9/19/21.
//

import SwiftUI

struct BusinessView: View {
    let business: BusinessViewModel
    let isHighestRated: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if isHighestRated {
                badge
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(business.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Group {
                        details
                        
                        ratings
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                
                Spacer()
                
                URLImage(urlString: business.imageURL)
                    .frame(width: 75, height: 75)
                    .cornerRadius(5)
                    .padding([.leading, .vertical], 5)
            }
            
            Divider()
        }
    }
    
    var badge: some View {
        Label("Highest Rated", systemImage: "star.fill")
            .foregroundColor(.white)
            .font(.system(size: 10, weight: .regular, design: .default))
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background(Color.blue.opacity(0.5))
            .cornerRadius(5)
    }
    
    var details: some View {
        VStack(alignment: .leading) {
            Text(business.address)
                .lineLimit(1)

            Text(business.phoneNumber)
                + Text(business.price)
        }
        .padding(.bottom, 1)
    }
    
    var ratings: some View {
        HStack {
            Label(business.rating, systemImage: "star.fill")
                .star()
                
            Text(business.reviewCount)
                + Text(" on Yelp")
            
            Spacer()
        }
    }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView(business: BusinessViewModel(business: .example), isHighestRated: true)
            .preferredColorScheme(.dark)
            .padding()
    }
}
