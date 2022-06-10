//
//  Constants.swift
//  Chat App
//
//  Created by HAMZA on 31/5/2022.
//

struct Constants {
    static let appName = "⚡️Chat App⚡️"
}

struct BrandColors {
    static let purple = "BrandPurple"
    static let lightPurple = "BrandLightPurple"
    static let blue = "BrandBlue"
    static let lighBlue = "BrandLightBlue"
}

struct CloudStore {
    static let collectionName = "messages"
    static let senderField = "sender"
    static let bodyField = "body"
    static let dateField = "date"
}

struct Segues {
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
}

struct Identifiers {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
}
