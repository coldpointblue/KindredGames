//  ----------------------------------------------------
//
//  KindredGamesApp.swift
//  Version 1.0
//
//  Unique ID:  7F0EC435-5FC6-48AB-8C26-31C9BAC299B6
//
//  part of the KindredGamesâ„˘ product.
//
//  Written in Swift 5.0 on macOS 12.5
//
//  https://github.com/coldpointblue
//  Created by Hugo Diaz on 08/09/22.
//
//  ----------------------------------------------------

//  ----------------------------------------------------
/*  Goal explanation:  Load JSON file and display game titles + images.   */
//  ----------------------------------------------------

import SwiftUI

@main
struct KindredGamesApp: App {
    @StateObject var gameCoversViewModel = GameCoversViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(gameCoversViewModel)
        }
    }
}
