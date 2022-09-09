//  ----------------------------------------------------
//
//  Constants.swift
//  Version 1.0
//
//  Unique ID:  3281F54C-0C1F-45CC-A6DF-9BBD74842F9B
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
/*  Goal explanation:  Keep prototyping constants in one place
 to alter easily. */
//  ----------------------------------------------------

import SwiftUI

struct World {
    static let gameInfoListURL = "https://api.unibet.com/game-library-rest-api/getGamesByMarketAndDevice.json"
        + "?jurisdiction=UK&brand=unibet&deviceGroup=mobilephone"
        + "&locale=en_GB&currency=GBP&categories=casino,softgames&clientId=casinoapp"

    static let sourceURLInvalidErrorMessage: String = "\r—————— invalid URL\r"
    static let jsonNoDataErrorMessage: String = "Network Error:\n  Data\n      missing"
    static let webDataDownloadErrorMessage: String = "\r—————— data download ERROR\r"
    static let jsonErrorDecodingMessage: String = "\r—————— JSON Decoder ERROR\r"
}

#if PRODUCTION
#else
func printWithinBodyWherever(_ someVars: Any...) -> some View {
    for beautyWithin in someVars { print("----> \(beautyWithin) <-----") }
    return EmptyView()
}
#endif
