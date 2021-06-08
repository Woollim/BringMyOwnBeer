//
//  HomeReactor.swift
//  BringMyOwnBeer🍺
//
//  Created by 이병찬 on 2021/06/07.
//  Copyright © 2021 Boyoung Park. All rights reserved.
//

import Foundation
import ReactorKit
import RxCocoa
import RxSwift

class HomeReactor: Reactor {

    enum Action {
        case viewDidLoad
        case tabChanged(HomeViewController.Tab)
        case viewDidDisappear
    }

    enum Mutation {
        case changeTab(HomeViewController.Tab)
        case showToast(message: String)
    }

    class State {
        var currentTab = HomeViewController.Tab.beerList
        var toastMessage: String?
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .just(.showToast(message: "환영합니다."))
        case .tabChanged(let tab):
            return .just(.changeTab(tab))
        case .viewDidDisappear:
            return .empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        let newState = state
        switch mutation {
        case .changeTab(let tab):
            newState.currentTab = tab
        case .showToast(let message):
            newState.toastMessage = message
        }
        return newState
    }
}
