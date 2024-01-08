//
//  Date+Extension.swift
//  Itinerary
//
//  Created by Vladimir Fibe on 07.01.2024.
//

import Foundation

extension Date {
    func add(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }

    var mediumDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
