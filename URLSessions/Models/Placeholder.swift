//
//  QuickType.swift
//  URLSessions
//
//  Created by Владимир Свиридов on 07.02.2022.
//

import Foundation

// MARK: - Placeholder
struct Placeholder: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
