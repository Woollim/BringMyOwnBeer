//
//  BeerListReactor.swift
//  BringMyOwnBeer🍺
//
//  Created by 이병찬 on 2021/06/07.
//  Copyright © 2021 Boyoung Park. All rights reserved.
//

import Foundation
import ReactorKit
import RxCocoa
import RxSwift

class BeerListReactor: Reactor {
    enum Action {
        case viewDidLoad
        case didDisplayLastCell
        case beerSelected(index: Int)
    }

    enum Mutation {
        case appendBeers([Beer])
        case setLoadingIndicator(Bool)
        case showToast(message: String)
        case presentBeerDetail(Beer)
    }

    class State {
        var beers = [Beer]()
        var showLoadingIndicator = false
        var toastMessage: String?
        var presentBeerDetail: Beer?

        fileprivate var currentPage = 1
    }

    let initialState = State()
    let repository = PunkRepositoryImpl()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad, .didDisplayLastCell:
            if currentState.showLoadingIndicator {
                return .empty()
            }
            return repository.getBeers(page: currentState.currentPage)
                .asObservable()
                .map { result -> Mutation in
                    switch result {
                    case .success(let beers):
                        return .appendBeers(beers)
                    case .failure(let error):
                        return .showToast(message: error.message)
                    }
                }
                .startWith(.setLoadingIndicator(true))
                .concat(Observable.just(.setLoadingIndicator(false)))
        case .beerSelected(let index):
            let selectedBeer = currentState.beers[index]
            return .just(.presentBeerDetail(selectedBeer))
        }
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        mutation.observe(on: MainScheduler.asyncInstance)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        let newState = state
        switch mutation {
        case .appendBeers(let beers):
            newState.currentPage += 1
            newState.beers += beers
        case .setLoadingIndicator(let show):
            newState.showLoadingIndicator = show
        case .showToast(let message):
            newState.toastMessage = message
        case .presentBeerDetail(let beer):
            newState.presentBeerDetail = beer
        }
        return newState
    }
}
