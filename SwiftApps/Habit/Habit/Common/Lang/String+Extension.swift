//
//  String+Extension.swift
//  Habit
//
//  Created by Mateus Lopes on 03/11/24.
//

import Foundation

extension String {
    func characterAtIndex(index: Int) -> Character? {
        var curr = 0
        for char in self {
            if curr == index {
                return char
            }
            curr = curr + 1
        }
        
        return nil
    }
    
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    func toDate(sourcePattern source: String, destPattern dest: String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormated = formatter.date(from: self)
        
        guard let dateFormated else {
            return nil
        }
        
        formatter.dateFormat = dest
        return formatter.string(from: dateFormated)
    }
    
    func toDate(sourcePattern source: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source

        return formatter.date(from: self)
    }
}
