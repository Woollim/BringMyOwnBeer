//
//  PunkRepository.swift
//  BringMyOwnBeer🍺
//
//  Created by Bo-Young PARK on 2019/10/29.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
import RxSwift

protocol PunkRepository {
    func getBeers(page: Int) -> Single<Result<[Beer], PunkError>>
    func getBeer(id: String) -> Single<Result<[Beer], PunkError>>
    func getRandomBeer() -> Single<Result<[Beer], PunkError>>
}
