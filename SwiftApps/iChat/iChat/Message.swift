//
//  Message.swift
//  iChat
//
//  Created by Mateus Lopes on 09/03/26.
//

import Foundation

struct Message: Hashable {
    let uuid: UUID
    let text: String
    let isMe: Bool
}
