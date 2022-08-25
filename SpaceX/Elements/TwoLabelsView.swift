//
//  TwoLabelsView.swift
//  SpaceX
//
//  Created by Анна Сычева on 19.08.2022.
//

import UIKit

final class TwoLabelsView: UIView {
    
    // MARK: - Private properties
    
    private lazy var stackView = makeStackView()
    private lazy var firstLabel = makeTitleLabel()
    private lazy var secondLabel = makeSubTitleLabel()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = .clear

        addSubview(stackView)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Configurable

extension TwoLabelsView {
    
    @discardableResult
    func configured(with model: RocketInfoModel) -> Self {
        firstLabel.text = model.title
        secondLabel.text = model.subTitle
        return self
    }
}

// MARK: - Factory

private extension TwoLabelsView {
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Color.lighLightGrey
        label.font = UIFont(name: Constants.font, size: 16)
        label.textAlignment = .left
        return label
    }
    
    func makeSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Color.darkWhite
        label.font = UIFont(name: Constants.font, size: 16)
        label.textAlignment = .right
        return label
    }
}

// MARK: - Constants

private extension TwoLabelsView {
    
    enum Constants {
        static let font: String = "LabGrotesque-Medium"
    }
}
