//
//  MainViewModel.swift
//  BringMyOwnBeer🍺
//
//  Created by Boyoung Park on 14/06/2019.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel: MainViewBindable {
    let beerListViewModel: BeerListViewBindable
    let singleBeerViewModel: SingleBeerViewBindable
    let randomBeerViewModel: RandomBeerViewBindable
    
    init() {
        self.beerListViewModel = BeerListViewModel()
        self.singleBeerViewModel = SingleBeerViewModel()
        self.randomBeerViewModel = RandomBeerViewModel()
    }
}
