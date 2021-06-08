//
//  PunkError.swift
//  BringMyOwnBeer🍺
//
//  Created by 이병찬 on 2021/06/07.
//  Copyright © 2021 Boyoung Park. All rights reserved.
//

import Foundation

enum PunkError: Error {
    case error(String)
    case defaultError

    var message: String {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "잠시 후에 다시 시도해주세요"
        }
    }
}
