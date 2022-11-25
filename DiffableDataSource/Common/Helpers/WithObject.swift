//
//  WithObject.swift
//  DiffableDataSource
//
//  Created by Александр Пахомов on 25.11.2022.
//

import Foundation

protocol WithObject: AnyObject {}

extension WithObject {
    func with(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: WithObject {}
