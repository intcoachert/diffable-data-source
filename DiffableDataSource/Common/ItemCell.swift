//
//  ItemWithIdCell.swift
//  DiffableDataSource
//
//  Created by Александр Пахомов on 25.11.2022.
//

import Foundation
import UIKit

final class ItemCell: UITableViewCell {
    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0

        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20))
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with Item: Item) {
        label.text = Item.title
    }
}
