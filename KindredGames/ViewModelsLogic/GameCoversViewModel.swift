//  ----------------------------------------------------
//
//  GameCoversViewModel.swift
//  Version 1.0
//
//  Unique ID:  A61298E6-5AC6-4F0C-A299-29807494FCED
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
/*  Goal explanation:  (whole app does? … for users)   */
//  ----------------------------------------------------

import SwiftUI
import Combine

class GameCoversViewModel: ObservableObject {
    @Published var jsonDataTruthInstance: GamesFetched = GamesFetched(games: [String: Game]())

    // Vars used in UI…
    @Published var statusFlash: String = ""
    @Published var totalShown: String = ""

    // Init…
    private let webSourceGameCovers: GameCoversProtocolType
    private var cancellables = Set<AnyCancellable>()

    init(gameInfoType: GameCoversProtocolType = GameInfoService()) {
        self.webSourceGameCovers = gameInfoType
    }

    // Messages as specific Input & Output triggers…
    enum SpecificInput {
        case viewDidAppear
        case refreshButtonTapped
    }
    let inputUpdateMessage: PassthroughSubject<GameCoversViewModel.SpecificInput, Never> = .init()

    enum SpecificOutput {
        case downloadFailed(error: Error)
        case downloadGameCoversSuccess(entireGameList: GamesFetched)
    }
    private let outputUpdateMessage: PassthroughSubject<SpecificOutput, Never> = .init()

    // Moving data through…
    func transform(inputTrigger: AnyPublisher<SpecificInput, Never>) -> AnyPublisher<SpecificOutput, Never> {
        inputTrigger.sink { [weak self] event in
            switch event {
            case .viewDidAppear, .refreshButtonTapped:
                self?.nowGetGameCoversJSON()
            }
        }.store(in: &cancellables)
        return outputUpdateMessage.eraseToAnyPublisher()
    }

    fileprivate func nowGetGameCoversJSON() {
        webSourceGameCovers.downloadGameInfoList()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.outputUpdateMessage.send(.downloadFailed(error: error))
                }
            } receiveValue: { [weak self] everyCurrentGameCover in
                self?.outputUpdateMessage.send(.downloadGameCoversSuccess(entireGameList: everyCurrentGameCover))
            }.store(in: &cancellables)
    }

    func bindJSONData() {
        let output = self.transform(inputTrigger: inputUpdateMessage.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .downloadGameCoversSuccess(let everyGameCoverInList):
                    self?.jsonDataTruthInstance = everyGameCoverInList
                case .downloadFailed(let error):
                    self?.statusFlash = error.localizedDescription
                }
            }
            .store(in: &cancellables)
    }
}
