//
//  File.swift
//  
//
//  Created by Cincinnati AI on 12/11/23.
//

import Foundation

public struct Body {
    public let contentType: String
    public let content: Data
    
    public init(contentType: String, content: Data) {
        self.contentType = contentType
        self.content = content
    }
}
