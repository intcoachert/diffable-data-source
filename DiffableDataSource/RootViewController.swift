//
//  Created by Александр Пахомов on 09.10.2022
//

import UIKit
import SnapKit

final class RootViewController: UIViewController {
    private lazy var mainScrollableStackView: UIScrollView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.addArrangedSubview(modelAsItemIdentifierButton)
        stack.addArrangedSubview(modelIdButton)
        stack.addArrangedSubview(modelIdFixedButton)

        let scroll = UIScrollView()
        scroll.contentInset.top = 20
        scroll.alwaysBounceVertical = true

        scroll.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalTo(scroll.contentLayoutGuide.snp.edges)
        }

        return scroll
    }()


    private lazy var modelAsItemIdentifierButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(openModelAsItemIdentifierVC), for: .touchUpInside)
        button.setTitle("ItemIdentifierType == Item", for: .normal)
        return button
    }()

    private lazy var modelIdButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(openItemIdVC), for: .touchUpInside)
        button.setTitle("ItemIdentifierType == Item.ID", for: .normal)
        return button
    }()

    private lazy var modelIdFixedButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(openItemIdFixedVC), for: .touchUpInside)
        button.setTitle("ItemIdentifierType == Item.ID + reconfigureItems", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Хаб"
        view.backgroundColor = .white

        view.addSubview(mainScrollableStackView)
        mainScrollableStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        mainScrollableStackView.contentLayoutGuide.snp.makeConstraints { make in
            make.width.equalTo(self.view.snp.width)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @objc
    private func openModelAsItemIdentifierVC() {
        let viewModel = CommonViewModel()
        let tableManager = ModelAsItemIdentifierTableManager()
        let controller = CommonViewController(viewModel: viewModel, tableManager: tableManager)
        viewModel.view = controller
        controller.set(title: "ItemIdentifierType == Item. Всё хорошо, кроме обновления видимых ячеек - у них анимация смены ячейки")
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc
    private func openItemIdVC() {
        let viewModel = CommonViewModel()
        let tableManager = ModelIdAsItemIdentifierTableManager()
        let controller = CommonViewController(viewModel: viewModel, tableManager: tableManager)
        viewModel.view = controller
        controller.set(title: "ItemIdentifierType == Item.ID. Обновление видимых ячеек вообще не работает")
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc
    private func openItemIdFixedVC() {
        let viewModel = CommonViewModel()
        let tableManager = ModelIdAsItemIdentifierFixedTableManager()
        let controller = CommonViewController(viewModel: viewModel, tableManager: tableManager)
        viewModel.view = controller
        controller.set(title: "ItemIdentifierType == Item.ID + обновление изменённых ячеек руками. Работает всё!")
        navigationController?.pushViewController(controller, animated: true)
    }
}
