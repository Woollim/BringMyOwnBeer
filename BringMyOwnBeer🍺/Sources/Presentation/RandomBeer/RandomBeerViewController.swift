//
//  RandomBeerViewController.swift
//  BringMyOwnBeer🍺
//
//  Created by Boyoung Park on 14/06/2019.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

class RandomBeerViewController: BaseViewController, View {

    typealias Action = RandomBeerReactor.Action

    let beerImageView = UIImageView()
    let idLabel = UILabel()
    let beerNameLabel = UILabel()
    let beerDescriptionLabel = UILabel()
    let randomButton = UIButton()
    let loadingIndicator = UIActivityIndicatorView()

    func bind(reactor: RandomBeerReactor) {
        reactor.state.map(\.beer)
            .bind(onNext: { [weak self] beer in
                self?.beerImageView.sd_setImage(with: URL(string: beer?.imageURL ?? ""))
                self?.idLabel.text = beer?.id.map { "\($0)" } ?? "찾지 못 함"
                self?.beerNameLabel.text = beer?.name
                self?.beerDescriptionLabel.text = beer?.description
            })
            .disposed(by: disposeBag)

        reactor.state.map(\.showLoadingIndicator)
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        reactor.state.map(\.toastMessage)
            .compactMap { $0 }
            .bind(to: self.rx.toast())
            .disposed(by: disposeBag)

        randomButton.rx.tap
            .map { _ in Action.randomButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    override func attribute() {
        self.do {
            $0.title = "랜덤 게임"
        }

        idLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .light)
            $0.textColor = .brown
        }

        beerNameLabel.do {
            $0.font = .systemFont(ofSize: 18, weight: .black)
            $0.textColor = .darkGray
            $0.numberOfLines = 0
        }

        beerDescriptionLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .light)
            $0.textColor = .gray
            $0.numberOfLines = 0
        }

        beerImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
        }

        randomButton.do {
            $0.setTitle("I'm Feeling Lucky", for: .normal)
            $0.backgroundColor = self.view.tintColor
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
        }

        loadingIndicator.do {
            $0.color = .darkGray
            $0.hidesWhenStopped = true
        }
    }

    override func layout() {
        view.addSubview(beerImageView)
        view.addSubview(idLabel)
        view.addSubview(beerNameLabel)
        view.addSubview(beerDescriptionLabel)
        view.addSubview(randomButton)
        view.addSubview(loadingIndicator)

        beerImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(240)
        }

        idLabel.snp.makeConstraints {
            $0.top.equalTo(beerImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        beerNameLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        beerDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(beerNameLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }

        randomButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
