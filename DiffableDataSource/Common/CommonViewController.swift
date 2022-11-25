//
//  Created by Александр Пахомов on 25.11.2022
//

import UIKit

protocol ManagesTable: AnyObject {
    func set(tableView: UITableView)
    func updateTable(with items: [Item])
}

final class CommonViewController: UIViewController, ViewProtocol {
    private let viewModel: CommonViewModel
    private let tableManager: ManagesTable

    private let headerView = UITextView().with { view in
        view.textColor = .gray
        view.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        view.font = .systemFont(ofSize: 14)
        view.isScrollEnabled = false
    }

    private lazy var tableView = UITableView(frame: .zero, style: .plain)

    private lazy var buttonsView = ButtonsView().with { view in
        view.onReloadButtonTap = self.viewModel.reloadDataDidTap
        view.onAppendButtonTap = self.viewModel.appendItemButtonDidTap
        view.onInsertButtonTap = self.viewModel.insertButtonDidTap
        view.onUpdateButtonTap = self.viewModel.updateButtonDidTap
    }

    init(viewModel: CommonViewModel, tableManager: ManagesTable) {
        self.viewModel = viewModel
        self.tableManager = tableManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        view.addSubview(buttonsView)

        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(buttonsView.snp.top)
        }

        buttonsView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }

        tableManager.set(tableView: tableView)
        viewModel.viewDidLoad()
    }

    func configure(with items: [Item]) {
        tableManager.updateTable(with: items)
    }

    func set(title: String) {
        headerView.text = title
        headerView.frame.size = headerView.sizeThatFits(UIScreen.main.bounds.size)
        tableView.tableHeaderView = headerView
    }
}
