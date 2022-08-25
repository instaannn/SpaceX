//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Анна Сычева on 25.08.2022.
//

import UIKit

// MARK: - LaunchesViewController

final class LaunchesViewController: UIViewController {
    
    // MARK: - Public properties
    
    var nameRocket = ""
    
    // MARK: - Private properties
    
    private lazy var stackView = makeStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }
    
    
    // MARK: - Action
    
    @objc
    private func backActionTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Setup

private extension LaunchesViewController {
    
    func setupUI() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(
            LauncheView().configured(
                with: RocketInfoModel(
                    title: "FalconSat",
                    subTitle: "2 февраля, 2022"
                )
            )
        )
        stackView.addArrangedSubview(
            LauncheView().configured(
                with: RocketInfoModel(
                    title: "Heavy holidays",
                    subTitle: "6 января, 2022"
                )
            )
        )
        stackView.addArrangedSubview(
            LauncheView().configured(
                with: RocketInfoModel(
                    title: "CRS-24 Mission",
                    subTitle: "23 декабря, 2021"
                )
            )
        )
        
        setUpConstraints()
        setupNavigationController()
    }
    
    func setUpConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
    
    func setupNavigationController() {
        title = nameRocket
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(backActionTapped)
        )
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(
            [.foregroundColor: Color.darkWhite as Any],
            for: .normal
        )
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Color.darkWhite]
    }
}

// MARK: - Factory

private extension LaunchesViewController {
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }
}
