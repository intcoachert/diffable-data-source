//
//  CommonViewItem.swift
//  DiffableDataSource
//
//  Created by Александр Пахомов on 25.11.2022.
//

protocol ViewProtocol: AnyObject {
    func configure(with items: [Item])
}

final class CommonViewModel {
    weak var view: ViewProtocol?
    private var items: [Item] = []
    private var counter = 0

    func viewDidLoad() {
        items = getInitialItems()
        view?.configure(with: items)
    }

    func reloadDataDidTap() {
        items = getInitialItems()
        view?.configure(with: items)
    }

    func appendItemButtonDidTap() {
        let newItem = getNewItem(suffix: "Just Appended!")
        items.append(newItem)
        view?.configure(with: items)
    }

    func insertButtonDidTap() {
        let newItem = getNewItem(suffix: "Just Inserted!")
        items.insert(newItem, at: items.count / 2)
        view?.configure(with: items)
    }

    func updateButtonDidTap() {
        guard var item = items.last else { return }

        item.title = "Item \(item.id) Just Updated!"
        items[items.count - 1] = item
        view?.configure(with: items)
    }

    func findItem(by id: Item.ID) -> Item? {
        items.first(where: { $0.id == id })
    }
}

private extension CommonViewModel {
    func getInitialItems() -> [Item] {
        counter = 4

        return (0..<4).map { index -> Item in
            Item(id: index, title: "Item \(index)")
        }
    }

    func getNewItem(suffix: String) -> Item {
        counter += 1

        return Item(id: counter - 1, title: "Item \(counter - 1) \(suffix)")
    }
}
