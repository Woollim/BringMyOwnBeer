//
//  BeerListCell.swift
//  BringMyOwnBeer🍺
//
//  Created by Boyoung Park on 14/06/2019.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SnapKit
import UIKit

class BeerListCell: UITableViewCell {
    let idLabel = UILabel()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let beerImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(beer: Beer) {
        idLabel.do {
            $0.text = beer.id.map { "\($0)" } ?? "찾지 못 함"
        }

        nameLabel.do {
            $0.text = beer.name
        }

        descriptionLabel.do {
            $0.text = beer.description
        }

        beerImageView.do {
            $0.sd_setImage(with: URL(string: beer.imageURL ?? ""))
        }
    }

    func attribute() {
        idLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .light)
            $0.textColor = .brown
        }

        nameLabel.do {
            $0.font = .systemFont(ofSize: 18, weight: .black)
            $0.textColor = .darkGray
            $0.numberOfLines = 0
        }

        descriptionLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .light)
            $0.textColor = .gray
            $0.numberOfLines = 0
        }

        beerImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
        }
    }

    func layout() {
        addSubview(idLabel)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(beerImageView)

        beerImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(120)
        }

        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(beerImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(4)
            $0.leading.equalTo(idLabel)
            $0.trailing.equalToSuperview().offset(-8)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6).priority(1000)
            $0.bottom.lessThanOrEqualToSuperview().offset(-16).priority(800)
            $0.leading.equalTo(idLabel)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
}
