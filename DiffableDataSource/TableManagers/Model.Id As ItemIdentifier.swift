//
//  Created by Александр Пахомов on 25.11.2022
//

import UIKit

// Чуть более сложная реализация
// ItemIdentifierType == Item.ID
// В данном случае обновление вообще не работает, так как DataSource, видя только идентификаторы элементов,
// не может понять, поменялся ли сам элемент - в UI ячейки вообще не обновляются
final class ModelIdAsItemIdentifierTableManager: ManagesTable {
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

    func updateTable(with items: [Item]) {
        self.items = items

        guard let dataSource = dataSource else {
            return
        }

        // Создаём новый снэпшот
        var snapshot = SnapshotType()

        // Описываем, что хотим видеть на экране
        snapshot.appendSections(["section-1"])
        snapshot.appendItems(items.map(\.id))

        // DiffableDataSource сам посчитает, какую ячейку добавить, какую удалить, какую подвинуть
        // "идентичность" проверяется по `hashValue` и сравнению через `==`

        // Но в данном случае мы передаём в него только идентификаторы элементов
        // Поэтому, если поменяется контент (item.title), DataSource этого не поймёт
        // Из-за этого нажатине на "Update" ничего не делает - DataSource просто не видит изменений!
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func provideCell(_ tableView: UITableView, indexPath: IndexPath, itemId: Item.ID) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item-cell", for: indexPath)

        if let cell = cell as? ItemCell, let item = items.first(where: { $0.id == itemId }) {
            cell.configure(with: item)
        }

        return cell
    }
}
