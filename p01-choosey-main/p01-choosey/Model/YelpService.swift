//
//  File.swift
//  Choosey Woosey
//
//  Created by Samuel Shi on 8/5/21.
//

import Foundation

enum NetworkError: String, Error {
    case invalidUrl = "Invalid URL."
    case failedRequest = "The network request failed."
    case missingData = "Did not receive expected data."
}

enum YelpService {
    static func getBusinesses(term: String, radius: Int, completion: @escaping (Result<[Business], NetworkError>) -> Void) {
        let baseUrl = "https://api.yelp.com/v3/businesses/search"
        var components = URLComponents(string: baseUrl)

        components?.queryItems = [
            URLQueryItem(name: "latitude", value: "35.913200"),
            URLQueryItem(name: "longitude", value: "-79.055847"),
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "radius", value: "\(radius.converted(from: .miles, to: .meters))"),
        ]

        guard let url = components?.url else {
            completion(.failure(.invalidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Secrets.yelpAPIKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data else {
                completion(.failure(.failedRequest))
                return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response.businesses))
            } catch {
                print(String(describing: error))
                completion(.failure(.missingData))
            }

        }.resume()
    }
}
