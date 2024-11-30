//
//  User.swift
//  BostaTasks
//
//  Created by Haneen Medhat on 28/11/2024.
//

import Foundation

struct User : Codable {
    let id : Int?
    let name : String?
    let address : Address?
}

struct Address: Codable {
    let street : String?
    let suite : String?
    let city : String?
    let zipcode : String?
}
