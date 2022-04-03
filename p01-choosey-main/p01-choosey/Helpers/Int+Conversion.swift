//
//  Int+Conversion.swift
//  p01-choosey
//
//  Created by Samuel Shi on 9/20/21.
//

import Foundation

extension Int {
    func converted(from: UnitLength, to: UnitLength) -> Int{
        return Int(Measurement(value: Double(self), unit: from).converted(to: to).value)
    }
}
