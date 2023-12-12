//
//  File.swift
//  
//
//  Created by Cincinnati AI on 12/11/23.
//

import Foundation

public struct QueryParameter {
    public let name: String
    public let value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}
