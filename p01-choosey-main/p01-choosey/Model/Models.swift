//
//  Place.swift
//  Choosey Woosey
//
//  Created by Samuel Shi on 8/5/21.
//

import Foundation

// MARK: RESPONSE
// - type representing the json response received from the Yelp API
struct Response: Codable {
    let businesses: [Business]
    let region: Region
}

// MARK: BUSINESS

struct Business: Codable {
    let categories: [Category]
    let coordinates: Coordinate
    let display_phone: String
    let distance: Double
    let id: String
    let alias: String
    let image_url: String
    let is_closed: Bool
    let location: Location
    let name: String
    let phone: String
    let price: String?
    let rating: Double
    let review_count: Int
    let url: String
    let transactions: [String]
}

struct Category: Codable {
    let alias: String
    let title: String
}

struct Location: Codable {
    let address1: String
    let address2: String?
    let address3: String?
    let city: String
    let country: String
    let display_address: [String]
    let state: String
    let zip_code: String
}

// MARK: REGION

struct Region: Codable {
    let center: Coordinate
}

// MARK: COORDINATE

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

extension Business {
    static let example = Business(categories: [],
                                  coordinates: Coordinate(latitude: 37, longitude: -79),
                                  display_phone: "(919) 280-1610",
                                  distance: 1.12,
                                  id: "1234",
                                  alias: "",
                                  image_url: "",
                                  is_closed: false,
                                  location: Location(address1: "600 Martin Luther King Jr. Blvd",
                                                     address2: nil,
                                                     address3: nil,
                                                     city: "Chapel Hill",
                                                     country: "United States",
                                                     display_address: [],
                                                     state: "North Carolina",
                                                     zip_code: "27514"),
                                  name: "Starbucks",
                                  phone: "9192801610",
                                  price: "$$",
                                  rating: 4.5,
                                  review_count: 33,
                                  url: "https://www.starbucks.com",
                                  transactions: [])
}
