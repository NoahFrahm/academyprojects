//
//  BusinessViewModel.swift
//  p01
//
//  Created by Samuel Shi on 9/19/21.
//

import Foundation

struct BusinessViewModel {
    private let business: Business
    
    init(business: Business) {
        self.business = business
    }
    
    var name: String {
        business.name
    }
    
    var distance: String {
        String(format: "%.1f", business.distance) + " mi"
    }
    
    var phoneNumber: String {
        business.display_phone
    }
    
    var isClosed: String {
        business.is_closed ? "Closed" : "Open"
    }
    
    var rating: String {
        String(business.rating)
    }
    
    var reviewCount: String {
        "(\(business.review_count))"
    }
    
    var address: String {
        business.location.address1 + ", " + business.location.city
    }
    
    var imageURL: String {
        business.image_url
    }
    
    var price: String {
        business.price == nil ? "" : (" · " + business.price!)
    }
}
