//
//  Item.swift
//  DiffableDataSource
//
//  Created by Александр Пахомов on 25.11.2022.
//

import Foundation

struct Item: Hashable, Identifiable {
    let id: Int
    var title: String
}
