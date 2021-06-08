//
//  BeerListViewController.swift
//  BringMyOwnBeer🍺
//
//  Created by Boyoung Park on 13/06/2019.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxViewController
import SnapKit
import Toaster
import UIKit

class BeerListViewController: BaseViewController, View {

    typealias Action = BeerListReactor.Action

    let tableView = UITableView()
    let loadingIndicator = UIActivityIndicatorView()

    func bind(reactor: BeerListReactor) {

        reactor.state.map(\.beers)
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: BeerListCell.self), cellType: BeerListCell.self)) { _, beer, cell in
                cell.setData(beer: beer)
            }
            .disposed(by: disposeBag)

        reactor.state.map(\.showLoadingIndicator)
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        reactor.state.map(\.toastMessage)
            .compactMap { $0 }
            .bind(to: self.rx.toast())
            .disposed(by: disposeBag)

//        reactor.state.map(\.presentBeerDetail)
//            .compactMap { $0 }
//            .bind(onNext: { [weak self] _ in
//            })
//            .disposed(by: disposeBag)

        self.rx.viewDidLoad
            .map { Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .map { Action.beerSelected(index: $0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    override func attribute() {
        super.attribute()

        self.do {
            $0.title = "맥주들"
            $0.navigationController?.navigationBar.prefersLargeTitles = true
        }

        tableView.do {
            $0.register(BeerListCell.self, forCellReuseIdentifier: String(describing: BeerListCell.self))
            $0.rowHeight = UITableViewAutomaticDimension
            $0.estimatedRowHeight = 160
        }

        loadingIndicator.do {
            $0.color = .darkGray
            $0.hidesWhenStopped = true
        }
    }

    override func layout() {
        super.layout()
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
