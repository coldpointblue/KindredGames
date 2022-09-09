//  ----------------------------------------------------
//
//  GameNetwork.swift
//  Version 1.0
//
//  Unique ID:  261494B0-129C-4D39-AADC-EBD69F6F9C95
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
/*  Goal explanation:  Fetch games JSON to automatically
 update UI using Combine.   */
//  ----------------------------------------------------

import Foundation
import Combine

// MARK: - Combine Network Service to download game numbers JSON data.
protocol GameCoversProtocolType {
    func downloadGameInfoList() -> AnyPublisher<GamesFetched, Error>
}

class GameInfoService: GameCoversProtocolType {

    func downloadGameInfoList() -> AnyPublisher<GamesFetched, Error> {
        let validAddress = doubleCheckWebAddress(World.gameInfoListURL)
        let url = URL(string: validAddress)!
        let request = URLRequest(url: url)
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }.map({
                $0.data
            })
            .decode(type: GamesFetched.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Network helpers.
func doubleCheckWebAddress(_ givenAddress: String) -> String {
    // In Production this would be actual verification for source address parts.
    guard let liveWebURL = URL(string: givenAddress),
          let validWebURL = URLRequest(url: liveWebURL).url?.absoluteString else {
        return ""
    }
    return validWebURL
}

#if PRODUCTION
#else
// MARK: - Debugging helpers to print fetched JSON data or response status code.
private func debugPrintIncomingData(_ incomingData: Data) {
    print("\r\r" + String(data: incomingData, encoding: .utf8)! +
            "\r——————————————>>>DOWNLOADED", terminator: "\r")
}

private func debugPrintStatusCode(_ webResponse: URLResponse) {
    print((webResponse as? HTTPURLResponse)?.statusCode as Any,
          terminator: " <<<——— RESPONSE statusCode\r\r")
}
#endif
