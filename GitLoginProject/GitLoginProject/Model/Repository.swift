//
//  Repository.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 29.01.26.
//


struct Repository: Identifiable, Decodable {
    let id: Int
    let name: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
    }
}
