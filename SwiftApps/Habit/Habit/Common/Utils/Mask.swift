//
//  Mask.swift
//  Habit
//
//  Created by Mateus Lopes on 09/09/25.
//

import Foundation

class Mask {
    static var isUpdating = false
    static var oldString = ""
    
    private static func replaceChars(full: String) -> String {
        full.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
    static func mask(mask: String, value: String, text: inout String){
        let str = Mask.replaceChars(full: value)
        var cpfWithMask = ""
        
        var _mask = mask
        
        if (str <= oldString){ // deleting chars with keyboard
            isUpdating = true
        }
        
        if(isUpdating || value.count == mask.count){
            oldString = str
            isUpdating = false
            return
        }
        
        var i = 0
        for char in _mask {
            if(char != "#" && str.count > oldString.count){
                cpfWithMask = cpfWithMask + String(char)
                continue
            }
        }
        
        i = i + 1
           
        text = cpfWithMask
    }
}
