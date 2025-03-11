//
//  Date+Extension.swift
//  Habit
//
//  Created by Mateus Lopes on 10/03/25.
//
import Foundation

extension Date {
    func toString(destPattern dest: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dest
        
        return formatter.string(from: self)
    }
}
