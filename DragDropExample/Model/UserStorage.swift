// UserStorage.swift
// Copyright © Darkness Production. All rights reserved.

import SwiftUI

final class UserStorage: ObservableObject {
    static let shared = UserStorage()
    
    @Published var users: [String] = [
        "Jon Snow",
        "Daenerys Targaryen",
        "Tyrion Lannister",
        "Cersei Lannister",
        "Jaime Lannister",
        "Sansa Stark",
        "Arya Stark",
        "Bran Stark",
        "Jorah Mormont",
        "Lord Varys",
        "Tywin Lannister",
        "Margaery Tyrell",
        "Joffrey Baratheon",
        "Catelyn Stark",
        "Robb Stark",
        "Eddard Stark",
        "High Sparrow",
        "Robert Baratheon",
        "Renly Baratheon"
    ]
}
