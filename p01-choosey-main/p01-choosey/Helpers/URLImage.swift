//
//  UrlImageView.swift
//  NewsApp
//
//  Created by SchwiftyUI on 12/29/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject var urlImageModel: Model
    
    init(urlString: String) {
        urlImageModel = Model(urlString: urlString)
    }
    
    var body: some View {
        if let image = urlImageModel.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            Image(uiImage: URLImage.defaultImage)
                .renderingMode(.template)
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
    }
    
    static var defaultImage = UIImage(systemName: "photo")!
}

extension URLImage {
    class Model: ObservableObject {
        @Published var image: UIImage?
        var urlString: String
    
        init(urlString: String) {
            self.urlString = urlString
            
            if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
                self.image = cachedImage
            } else {
                getRemoteImage(urlString: urlString) { remoteImage in
                    self.image = remoteImage
                }
            }
        }
    
        func getRemoteImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard error == nil,
                          let data = data,
                          let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    
                    ImageCache.shared.set(image: image, forKey: urlString)
                    completion(image)
                }
            }.resume()
        }
    }

    class ImageCache {
        static var shared = ImageCache()
        var cache = NSCache<NSString, UIImage>()
    
        func getImage(forKey: String) -> UIImage? {
            return cache.object(forKey: NSString(string: forKey))
        }
    
        func set(image: UIImage, forKey: String) {
            cache.setObject(image, forKey: NSString(string: forKey))
        }
    }
}
