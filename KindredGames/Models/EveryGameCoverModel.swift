//  ----------------------------------------------------
//
//  EveryGameCoverModel.swift
//  Version 1.0
//
//  Unique ID:  15C1E184-83A5-4085-ADC2-724140167E0D
//
//  part of the KindredGames™ product.
//
//  Written in Swift 5.0 on macOS 12.5
//
//  https://github.com/coldpointblue
//  Created by Hugo Diaz on 09/09/22.
//
//  ----------------------------------------------------

//  ----------------------------------------------------
/*  Goal explanation:  Define JSON data structure of game
 specifics such as images, titles. */
//  ----------------------------------------------------

import Foundation

struct GamesFetched: Codable {
    var games: [String: Game]
}

struct Game: Codable {
    let gameName: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case gameName
        case imageURL = "imageUrl"
    }

    static var exampleGameCover = Game(
        gameName: "Valkyries",
        imageURL: "https://www.unibet.co.uk/polopoly_fs/1.1921208.1638294471!/image/108991391.jpg"
    )
}
