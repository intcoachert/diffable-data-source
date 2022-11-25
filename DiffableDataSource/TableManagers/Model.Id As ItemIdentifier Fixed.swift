//
//  Created by Александр Пахомов on 25.11.2022
//

import UIKit

// Совершенная реализация
// ItemIdentifierType == Item.ID
// Тут всё работает
// Чтобы таблица обновила видимые ячейки, приходится руками смотреть, какие элементы поменялись
// и вызывать reconfigureItems для них
final class ModelIdAsItemIdentifierFixedTableManager: ManagesTable {
    private typealias DataSourceType = UITableViewDiffableDataSource<String, Item.ID>
    private typealias SnapshotType = NSDiffableDataSourceSnapshot<String, Item.ID>

    private var dataSource: DataSourceType?
    private var items: [Item] = []

    func set(tableView: UITableView) {
        tableView.register(ItemCell.self, forCellReuseIdentifier: "item-cell")

        let dataSource = DataSourceType(
            tableView: tableView,
            cellProvider: self.provideCell(_:indexPath:itemId:)
        )

        dataSource.defaultRowAnimation = .automatic

        self.dataSource = dataSource
    }

    func updateTable(with newItems: [Item]) {
        let oldItems = self.items
        self.items = newItems

        guard let dataSource = dataSource else {
            return
        }

        // Главное различие - этот меод!
        reconfigureChanged(oldItems: oldItems, newItems: newItems, in: dataSource)

        // Создаём новый снэпшот
        var snapshot = SnapshotType()

        // Описываем, что хотим видеть на экране
        snapshot.appendSections(["section-1"])
        snapshot.appendItems(newItems.map(\.id))

        // DiffableDataSource сам посчитает, какую ячейку добавить, какую удалить, какую подвинуть
        // "идентичность" проверяется по `hashValue` и сравнению через `==`

        // Этот вызов только добавит/удалит/переместит ячейки
        // Обновления контента видимых ячеек произошло в методе reconfigureChanged без анимации
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func provideCell(_ tableView: UITableView, indexPath: IndexPath, itemId: Item.ID) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item-cell", for: indexPath)

        if let cell = cell as? ItemCell, let item = items.first(where: { $0.id == itemId }) {
            cell.configure(with: item)
        }

        return cell
    }

    private func reconfigureChanged(oldItems: [Item], newItems: [Item], in dataSource: DataSourceType) {
        // Дополнительно руками завтавить DataSource обновить те ячейки, модельки которых поменялись

        let changedItems = newItems.filter { newItem -> Bool in
            guard let oldItem = oldItems.first(where: { $0.id == newItem.id }) else { return false }
            return oldItem != newItem
        }

        var snapshot = dataSource.snapshot()
        snapshot.reconfigureItems(changedItems.map(\.id))

        dataSource.apply(snapshot)
    }
}
