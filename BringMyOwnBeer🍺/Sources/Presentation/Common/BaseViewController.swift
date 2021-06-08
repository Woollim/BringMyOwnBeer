//
//  BaseViewController.swift
//  BringMyOwnBeer🍺
//
//  Created by 이병찬 on 2021/06/07.
//  Copyright © 2021 Boyoung Park. All rights reserved.
//

import RxSwift
import Then
import UIKit

class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }

    func attribute() {
        self.do {
            $0.view.backgroundColor = .white
        }
    }

    func layout() { }
}
