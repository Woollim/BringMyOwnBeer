//
//  Rx+Extension.swift
//  BringMyOwnBeer🍺
//
//  Created by 이병찬 on 2021/06/07.
//  Copyright © 2021 Boyoung Park. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

extension ObservableConvertibleType {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> Observable<T> {
        asObservable().map { $0[keyPath: keyPath] }
    }

    func map<T: Equatable>(_ keyPath: KeyPath<Element, T>) -> Observable<T> {
        asObservable().map { $0[keyPath: keyPath] }.distinctUntilChanged()
    }
}
