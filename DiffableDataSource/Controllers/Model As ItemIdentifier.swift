//
//  Created by Александр Пахомов on 25.11.2022
//

import UIKit

// Самая простая реализация
// ItemIdentifierType == Item. То есть вся структура
// Легко работает, но при попытке обновить ячейку проблема с анимацией:
// Вместо переконфигурации ячейки происходит удаление и вставка новой с обновлёнными данными
final class ModelAsItemIdentifierTableManager: ManagesTable {
    private typealias DataSourceType = UITableViewDiffableDataSource<String, Item>
    private typealias SnapshotType = NSDiffableDataSourceSnapshot<String, Item>

    private var dataSource: DataSourceType?

    func set(tableView: UITableView) {
        tableView.register(ItemCell.self, forCellReuseIdentifier: "item-cell")

        let dataSource = DataSourceType(
            tableView: tableView,
            cellProvider: self.provideCell(_:indexPath:item:)
        )

        dataSource.defaultRowAnimation = .automatic

        self.dataSource = dataSource
    }

    func updateTable(with items: [Item]) {
        guard let dataSource = dataSource else {
            return
        }

        // Создаём новый снэпшот
        var snapshot = SnapshotType()

        // Описываем, что хотим видеть на экране
        snapshot.appendSections(["section-1"])
        snapshot.appendItems(items)

        // DiffableDataSource сам посчитает, какую ячейку добавить, какую удалить, какую подвинуть
        // "идентичность" проверяется по `hashValue` и сравнению через `==`

        // Так как мы передаём в DataSource весь элемент (а не только item.id), то при изменении контента
        // (например, item.title), меняется хэш элемента - DataSource считает, что это уже ДРУГОЙ элемент
        // Поэтому когда хочешь поменять ячейку, фактически получаешь релоад (создание новой ячейки вместо старой)
        // То есть ожидаешь - reconfigure, а получаешь delete + insert
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func provideCell(_ tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item-cell", for: indexPath)

        if let cell = cell as? ItemCell {
            cell.configure(with: item)
        }

        return cell
    }
}
