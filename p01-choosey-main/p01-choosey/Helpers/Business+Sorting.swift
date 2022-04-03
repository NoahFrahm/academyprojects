//
//  Business+Sorting.swift
//  p01
//
//  Created by Samuel Shi on 9/19/21.
//

import Foundation

extension Array where Element == Business {
    func sorted(favoriteId: String?) -> [Business] {
        self.sorted { first, second in
            first.id == favoriteId ? true :
            second.id == favoriteId ? false :
            first.name > second.name
        }
    }
}
