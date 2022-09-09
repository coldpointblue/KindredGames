//  ----------------------------------------------------
//
//  ContentView.swift
//  Version 1.0
//
//  Unique ID:  D194B686-9E0F-4FE8-8931-E9CF60CB2201
//
//  part of the KindredGames™ product.
//
//  Written in Swift 5.0 on macOS 12.5
//
//  https://github.com/coldpointblue
//  Created by Hugo Diaz on 08/09/22.
//
//  ----------------------------------------------------

//  ----------------------------------------------------
/*  Goal explanation:  List game titles + images.   */
//  ----------------------------------------------------

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var everyGameCoverViewModel: GameCoversViewModel

    var body: some View {
        VStack {
            Spacer()
            Group {
                Text("Welcome to Kindred…")
                    .font(Font.title.weight(.bold))
                Text(everyGameCoverViewModel.statusFlash)
                    .font(.system(.callout, design: .monospaced))
                Text("  JSON has\n" +
                        "\(everyGameCoverViewModel.jsonDataTruthInstance.games.keys.count)"
                        + " games listed.")
                    .multilineTextAlignment(.center)
            }
            .padding(.top)

            listEveryGameCover()
            Text("Choose one to play now, have some fun!")
                .padding(.bottom)
                .font(.system(.footnote, design: .rounded))
        }
        .onAppear(perform: {
            // Use the Combine robust automatic way to load JSON.
            everyGameCoverViewModel.bindJSONData()
            everyGameCoverViewModel.inputUpdateMessage.send(.viewDidAppear)
        })
    }
}

// MARK: - Content list with gameCovers and their numbers.
extension ContentView {

    func listEveryGameCover() -> some View {
        let gameDictionary = everyGameCoverViewModel.jsonDataTruthInstance

        return List {
            Section(header: Text("Kindred Games")) {

                ForEach(Array(gameDictionary.games.keys.enumerated()), id: \.element) { number, key in
                    gameCoverInfo(key, number)
                }

            }
        }
        .listStyle(.inset)
    }

    fileprivate func gameCoverInfo(_ key: String, _ number: Int) -> some View {
        let gameDictionary = everyGameCoverViewModel.jsonDataTruthInstance

        return HStack {
            if let imageURL = gameDictionary.games[key]?.imageURL {
                AsyncImage(url: URL(string: imageURL), content: {
                    $0.resizable().aspectRatio(4/3, contentMode: ContentMode.fit)
                }, placeholder: {
                    ProgressView().frame(width: 100.0)
                })
            }
            Divider()
            VStack.init(alignment: SwiftUI.HorizontalAlignment.leading) {
                Text("#\(number + 1):")
                Text("\(gameDictionary.games[key]?.gameName ?? "………………… NAME MISSING")")
                    .font(SwiftUI.Font.headline)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameCoversViewModel())
    }
}
