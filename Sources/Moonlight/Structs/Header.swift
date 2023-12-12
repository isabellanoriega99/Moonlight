//
//  File.swift
//  
//
//  Created by Cincinnati AI on 12/11/23.
//

import Foundation

public struct Header {
    public let type: String
    public let value: String
    
    public init(type: String, value: String) {
        self.type = type
        self.value = value
    }
}
