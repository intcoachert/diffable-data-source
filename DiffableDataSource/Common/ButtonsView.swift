//
//  ButtonsView.swift
//  DiffableDataSource
//
//  Created by Александр Пахомов on 25.11.2022.
//

import UIKit
import SnapKit

final class ButtonsView: UIView {
    var onReloadButtonTap: Action?
    var onAppendButtonTap: Action?
    var onInsertButtonTap: Action?
    var onUpdateButtonTap: Action?

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical

        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        stack.spacing = 8

        stack.addArrangedSubview(reloadButton)
        stack.addArrangedSubview(appendButton)
        stack.addArrangedSubview(insertButton)
        stack.addArrangedSubview(updateButton)

        return stack
    }()

    private lazy var reloadButton = UIButton(type: .system).with { button in
        button.addTarget(self, action: #selector(reloadButtonDidTap), for: .touchUpInside)
        button.setTitle("Reload", for: .normal)
    }

    private lazy var appendButton = UIButton(type: .system).with { button in
        button.addTarget(self, action: #selector(appendButtonDidTap), for: .touchUpInside)
        button.setTitle("Append", for: .normal)
    }

    private lazy var insertButton = UIButton(type: .system).with { button in
        button.addTarget(self, action: #selector(insertButtonDidTap), for: .touchUpInside)
        button.setTitle("Insert", for: .normal)
    }

    private lazy var updateButton = UIButton(type: .system).with { button in
        button.addTarget(self, action: #selector(updateButtonDidTap), for: .touchUpInside)
        button.setTitle("Update", for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func reloadButtonDidTap() {
        onReloadButtonTap?()
    }

    @objc
    private func appendButtonDidTap() {
        onAppendButtonTap?()
    }

    @objc
    private func insertButtonDidTap() {
        onInsertButtonTap?()
    }

    @objc
    private func updateButtonDidTap() {
        onUpdateButtonTap?()
    }
}
