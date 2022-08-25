//
//  LauncheView.swift
//  SpaceX
//
//  Created by Анна Сычева on 25.08.2022.
//

import UIKit

final class LauncheView: UIView {
    
    // MARK: - Private properties
    
    private lazy var containerView = makeContainerView()
    private lazy var stackView = makeStackView()
    private lazy var firstLabel = makeTitleLabel()
    private lazy var secondLabel = makeSubTitleLabel()
    private lazy var rocketImage = makeRocketImageView()
    
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
        
        addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.addSubview(rocketImage)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        rocketImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            
            rocketImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            rocketImage.heightAnchor.constraint(equalToConstant: 32),
            rocketImage.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}

// MARK: - Configurable

extension LauncheView {
    
    @discardableResult
    func configured(with model: RocketInfoModel) -> Self {
        firstLabel.text = model.title
        secondLabel.text = model.subTitle
        return self
    }
}

// MARK: - Factory

private extension LauncheView {
    
    func makeContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = Color.lightBlack
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Constants.font, size: 20)
        label.textAlignment = .left
        return label
    }
    
    func makeSubTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Color.lightGrey
        label.font = UIFont(name: Constants.font, size: 16)
        label.textAlignment = .left
        return label
    }
    
    func makeRocketImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "rocket-25"))
        return imageView
    }
}

// MARK: - Constants

private extension LauncheView {
    
    enum Constants {
        static let font: String = "LabGrotesque-Medium"
    }
}
