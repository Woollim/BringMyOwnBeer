//
//  HomeViewController.swift
//  BringMyOwnBeer🍺
//
//  Created by 이병찬 on 2021/06/07.
//  Copyright © 2021 Boyoung Park. All rights reserved.
//

import Foundation
import ReactorKit
import RxCocoa
import RxSwift
import Then

class HomeViewController: UITabBarController, View {

    enum Tab: Int {
        case beerList = 0
        case searchBeer = 1
        case randomBeer = 2
    }

    typealias Action = HomeReactor.Action

    var disposeBag = DisposeBag()

    let beerListViewController = BeerListViewController().then {
        $0.reactor = BeerListReactor()
    }
    let searchBeerViewController = SearchBeerViewController().then {
        $0.reactor = SearchBeerReactor()
    }
    let randomBeerViewController = RandomBeerViewController().then {
        $0.reactor = RandomBeerReactor()
    }

    func bind(reactor: HomeReactor) {
        reactor.state.map(\.currentTab)
            .bind(onNext: { [weak self] tab in
                self?.selectedIndex = tab.rawValue
            })
            .disposed(by: disposeBag)

        self.rx.viewDidLoad
            .map { Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        self.rx.viewDidDisappear
            .map { _ in Action.viewDidDisappear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    func attribute() {
        self.do {
            $0.viewControllers = [
                UINavigationController(rootViewController: beerListViewController),
                UINavigationController(rootViewController: searchBeerViewController),
                UINavigationController(rootViewController: randomBeerViewController)
            ]
            $0.view.backgroundColor = .white
        }

        beerListViewController.do {
            $0.tabBarItem = UITabBarItem(title: "맥주들", image: #imageLiteral(resourceName: "Multiple Beers"), selectedImage: #imageLiteral(resourceName: "Multiple Beers"))
        }

        searchBeerViewController.do {
            $0.tabBarItem = UITabBarItem(title: "검색", image: #imageLiteral(resourceName: "Single Beer"), selectedImage: #imageLiteral(resourceName: "Single Beer"))
        }

        randomBeerViewController.do {
            $0.tabBarItem = UITabBarItem(title: "랜덤", image: #imageLiteral(resourceName: "Single Beer with bubble"), selectedImage: #imageLiteral(resourceName: "Single Beer with bubble"))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
}
