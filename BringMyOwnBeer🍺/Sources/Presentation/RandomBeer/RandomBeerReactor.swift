//
//  RandomBeerReactor.swift
//  BringMyOwnBeer🍺
//
//  Created by 이병찬 on 2021/06/08.
//  Copyright © 2021 Boyoung Park. All rights reserved.
//

import Foundation
import ReactorKit
import RxCocoa
import RxSwift

class RandomBeerReactor: Reactor {
    enum Action {
        case randomButtonTapped
    }

    enum Mutation {
        case setBeer(Beer?)
        case setLoadingIndicator(Bool)
        case showToast(message: String)
    }

    class State {
        var beer: Beer?
        var showLoadingIndicator = false
        var toastMessage: String?
    }

    let initialState = State()
    let repository = PunkRepositoryImpl()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .randomButtonTapped:
            if currentState.showLoadingIndicator == true {
                return .empty()
            }
            return repository.getRandomBeer().asObservable()
                .flatMap { result -> Observable<Mutation> in
                    switch result {
                    case .success(let beer):
                        return .just(.setBeer(beer))
                    case .failure(let error):
                        return .of(.setBeer(nil), .showToast(message: error.message))
                    }
                }
                .startWith(.setLoadingIndicator(true))
                .concat(Observable.just(.setLoadingIndicator(false)))
        }
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        mutation.observe(on: MainScheduler.asyncInstance)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        let newState = state
        switch mutation {
        case .setBeer(let beer):
            newState.beer = beer
        case .setLoadingIndicator(let show):
            newState.showLoadingIndicator = show
        case .showToast(let message):
            newState.toastMessage = message
        }
        return newState
    }
}
