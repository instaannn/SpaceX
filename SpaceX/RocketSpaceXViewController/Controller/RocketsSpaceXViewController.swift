//
//  RocketSpaceXViewController.swift
//  SpaceX
//
//  Created by Анна Сычева on 12.08.2022.
//

import UIKit

// MARK: - RocketSpaceXViewController

final class RocketSpaceXViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var scrollView = UIScrollView()
    private lazy var containerView = UIView()
    private lazy var rocketPhotoImageView = UIImageView()
    private lazy var backgroundView = makeBackgroundView()
    private lazy var nameLabel = makeNameLabel()
    private lazy var collectionView = makeCollectionView()
    private lazy var collectionViewFlowLayout = makeCollectionViewFlowLayout()
    private lazy var firstLaunchesStackView = makeStackView()
    
    private lazy var firstStageLabel = makeStageLabel(text: "ПЕРВАЯ СТУПЕНЬ")
    private lazy var firstStageStackView = makeStackView()
    
    private lazy var secondStageLabel = makeStageLabel(text: "ВТОРАЯ СТУПЕНЬ")
    private lazy var secondStageStackView = makeStackView()
    
    private lazy var showLaunchesButton = makeShowLaunchesButton()
    
    private lazy var items = [RocketInfoModel]()
    
    private var rocket: Rocket?
    
    // MARK: - Life cycle
    
    init(model: Rocket) {
        super.init(nibName: nil, bundle: nil)
        rocket = model
        guard let rocket = rocket else {
            return
        }
        
        self.nameLabel.text = rocket.name
        self.setupPhoto(url: rocket.flickrImages[0])
        self.items.append(RocketInfoModel(title: String(rocket.height.feet), subTitle: "Высота, ft"))
        self.items.append(RocketInfoModel(title: String(rocket.diameter.feet), subTitle: "Диаметр, ft"))
        self.items.append(RocketInfoModel(title: String(rocket.mass.lb), subTitle: "Масса, lb"))
        self.items.append(RocketInfoModel(title: String(rocket.payloadWeights[0].lb), subTitle: "Нагрузка, lb"))
        
        self.firstLaunchesStackView.addArrangedSubview(
            TwoLabelsView().configured(
                with: RocketInfoModel(
                    title: "Первый запуск",
                    subTitle: convertDateFormat(inputDate: rocket.firstFlight)
                )
            )
        )
        self.firstLaunchesStackView.addArrangedSubview(
            TwoLabelsView().configured(
                with: RocketInfoModel(title: "Страна", subTitle: rocket.country)
            )
        )
        self.firstLaunchesStackView.addArrangedSubview(
            TwoLabelsView().configured(
                with: RocketInfoModel(
                    title: "Стоимость запуска",
                    subTitle: convertIntCost(inputInt: rocket.costPerLaunch)
                )
            )
        )
        
        self.firstStageStackView.addArrangedSubview(
            TwoLabelsView().configured(
                with: RocketInfoModel(
                    title: "Количество двигателей",
                    subTitle: String(rocket.firstStage.engines)
                )
            )
        )
        self.firstStageStackView.addArrangedSubview(
            TwoLabelsView().configured(
                with: RocketInfoModel(
                    title: "Количество топлива",
                    subTitle: String(rocket.firstStage.fuelAmountTons)
                )
            )
        )
        if rocket.firstStage.burnTimeSec != nil {
            self.firstStageStackView.addArrangedSubview(
                TwoLabelsView().configured(
                    with: RocketInfoModel(
                        title: "Время сгорания",
                        subTitle: String(rocket.firstStage.burnTimeSec!)
                    )
                )
            )
        }
        
        self.secondStageStackView.addArrangedSubview(
            TwoLabelsView().configured(
                with: RocketInfoModel(
                    title: "Количество двигателей",
                    subTitle: String(rocket.secondStage.engines)
                )
            )
        )
        self.secondStageStackView.addArrangedSubview(
            TwoLabelsView().configured(
                with: RocketInfoModel(
                    title: "Количество топлива",
                    subTitle: String(rocket.secondStage.fuelAmountTons)
                )
            )
        )
        if rocket.secondStage.burnTimeSec != nil {
            self.secondStageStackView.addArrangedSubview(
                TwoLabelsView().configured(
                    with: RocketInfoModel(
                        title: "Время сгорания",
                        subTitle: String(rocket.secondStage.burnTimeSec!)
                    )
                )
            )
        }
        self.collectionView.reloadData()
    }
    
    // MARK: - Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupPhoto(url: String) {
        guard let url = URL(string: url) else { return }
        rocketPhotoImageView.load(url: url)
    }
    
    // MARK: - Actions
    
    @objc
    private func actionButton() {
        let viewController = LaunchesViewController()
        viewController.nameRocket = rocket?.name ?? ""
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Setup

private extension RocketSpaceXViewController {
    
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(rocketPhotoImageView)
        containerView.addSubview(backgroundView)
        backgroundView.addSubview(nameLabel)
        backgroundView.addSubview(collectionView)
        backgroundView.addSubview(firstLaunchesStackView)
        backgroundView.addSubview(firstStageLabel)
        backgroundView.addSubview(firstStageStackView)
        backgroundView.addSubview(secondStageLabel)
        backgroundView.addSubview(secondStageStackView)
        backgroundView.addSubview(showLaunchesButton)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        [scrollView,
         containerView,
         backgroundView,
         rocketPhotoImageView,
         nameLabel,
         collectionView,
         firstLaunchesStackView,
         firstStageLabel,
         firstStageStackView,
         secondStageLabel,
         secondStageStackView,
         showLaunchesButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        
            rocketPhotoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            rocketPhotoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            rocketPhotoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            rocketPhotoImageView.heightAnchor.constraint(equalToConstant: 300),
        
            backgroundView.topAnchor.constraint(equalTo: rocketPhotoImageView.bottomAnchor, constant: -30),
            backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 48),
            nameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
        
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 96),
            collectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
        
            firstLaunchesStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            firstLaunchesStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            firstLaunchesStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        
            firstStageLabel.topAnchor.constraint(equalTo: firstLaunchesStackView.bottomAnchor, constant: 40),
            firstStageLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            firstStageLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        
            firstStageStackView.topAnchor.constraint(equalTo: firstStageLabel.bottomAnchor, constant: 16),
            firstStageStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            firstStageStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        
            secondStageLabel.topAnchor.constraint(equalTo: firstStageStackView.bottomAnchor, constant: 40),
            secondStageLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            secondStageLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        
            secondStageStackView.topAnchor.constraint(equalTo: secondStageLabel.bottomAnchor, constant: 16),
            secondStageStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            secondStageStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
        
            showLaunchesButton.topAnchor.constraint(equalTo: secondStageStackView.bottomAnchor, constant: 40),
            showLaunchesButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            showLaunchesButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
            showLaunchesButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -40),
            showLaunchesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension RocketSpaceXViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as? RocketInfoCollectionViewCell else { return UICollectionViewCell() }
        cell.configured(with: items[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RocketSpaceXViewController: UICollectionViewDelegate { }

// MARK: - Factory

private extension RocketSpaceXViewController {
    
    func makeBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        return view
    }
    
    func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Color.darkWhite
        label.font = UIFont(name: Constants.fontMedium, size: 24)
        return label
    }
    
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(RocketInfoCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    func makeCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(
            width: 96,
            height: 96
        )
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        return layout
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }
    
    func makeStageLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = Color.darkWhite
        label.font = UIFont(name: Constants.fontBold, size: 16)
        label.text = text
        return label
    }
    
    func makeShowLaunchesButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Посмотреть запуски", for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.fontBold, size: 16)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(Color.darkWhite, for: .normal)
        button.layer.backgroundColor = Color.lightBlack.cgColor
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }
}

// MARK: - Constants

private extension RocketSpaceXViewController {
    
    enum Constants {
        static let cellId: String = "Cell"
        static let fontBold: String = "LabGrotesque-Bold"
        static let fontMedium: String = "LabGrotesque-Medium"
    }
}

// MARK: - Convert

private extension RocketSpaceXViewController {
    
    func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM, yyyy"
        
        return convertDateFormatter.string(from: oldDate)
    }
    
    func convertIntCost(inputInt: Int) -> String {
        let costString = inputInt / 1000000
        return "$\(costString) млн"
    }
}
