//
//  File.swift
//  
//
//  Created by Cincinnati AI on 12/11/23.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
}
