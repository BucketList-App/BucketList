//
//  DreamDTO.swift
//  
//
//  Created by Gleb Fandeev on 10.11.2023.
//

import Foundation

public struct DreamDTO: Decodable {
    public let id: String
    public let title: String
    public let description: String?
    public let imageData: Data?
    public let deadline: Date?
    public let isCompleted: Bool
}
