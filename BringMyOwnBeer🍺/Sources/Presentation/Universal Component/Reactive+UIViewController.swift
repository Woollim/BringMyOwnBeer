//
//  Reactive+UIViewController.swift
//  BringMyOwnBeer🍺
//
//  Created by Boyoung Park on 11/07/2019.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import RxSwift
import RxCocoa
import Toaster

extension Reactive where Base: UIViewController {
    func toast(delay: TimeInterval = 0, duration: TimeInterval = 0.8) -> Binder<String> {
        return Binder(base) { _, text in
            Toast(text: text, delay: delay, duration: duration).show()
        }
    }
}
