//
//  UIApplication+Website.swift
//  p01
//
//  Created by Samuel Shi on 9/19/21.
//

import SwiftUI

extension UIApplication {
    func openWebsite(for business: Business) {
      if let url = URL(string: business.url) {
          UIApplication.shared.open(url)
      }
    }
}
