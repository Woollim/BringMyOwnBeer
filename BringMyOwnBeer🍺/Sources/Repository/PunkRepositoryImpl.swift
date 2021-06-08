//
//  PunkNetworkImpl.swift
//  BringMyOwnBeer🍺
//
//  Created by Bo-Young PARK on 2019/10/29.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
import RxSwift

class PunkRepositoryImpl: PunkRepository {
    private let session = URLSession.shared

    func getBeers(page: Int) -> Single<Result<[Beer], PunkError>> {

        guard let url = URL(string: PunkAPI.baseURL + "/beers?page=\(page)") else {
            return .just(.failure(.defaultError))
        }

        return session.rx.data(request: URLRequest(url: url))
            .asSingle()
            .map { data in
                do {
                    let beers = try JSONDecoder().decode([Beer].self, from: data)
                    return .success(beers)
                } catch {
                    return .failure(.error(error.localizedDescription))
                }
            }
    }

    func getBeer(id: String) -> Single<Result<Beer, PunkError>> {

        guard let url = URL(string: PunkAPI.baseURL + "/beers/\(id)") else {
            return .just(.failure(.defaultError))
        }

        return session.rx.data(request: URLRequest(url: url))
            .asSingle()
            .map { data in
                do {
                    let beerList = try JSONDecoder().decode([Beer].self, from: data)
                    // swiftlint:disable force_unwrapping
                    return .success(beerList.first!)
                } catch {
                    return .failure(.error(error.localizedDescription))
                }
            }
    }

    func getRandomBeer() -> Single<Result<Beer, PunkError>> {

        guard let url = URL(string: PunkAPI.baseURL + "/beers") else {
            return .just(.failure(.defaultError))
        }

        return session.rx.data(request: URLRequest(url: url))
            .asSingle()
            .map { data in
                do {
                    let beers = try JSONDecoder().decode([Beer].self, from: data)
                    guard let randomBeer = beers.randomElement() else {
                        throw PunkError.error("getRandomBeer API 에러")
                    }
                    return .success(randomBeer)
                } catch {
                    return .failure(.error(error.localizedDescription))
                }
            }
    }
}
