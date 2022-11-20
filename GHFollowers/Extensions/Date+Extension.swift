//
//  Date+Extension.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 19.11.2022.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: self)
    }
}
