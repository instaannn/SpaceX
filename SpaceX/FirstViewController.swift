//
//  FirstViewController.swift
//  SpaceX
//
//  Created by Анна Сычева on 24.08.2022.
//

import UIKit

// MARK: - FirstViewController

final class FirstViewController: UIPageViewController {
    
    // MARK: - Private properties
    
    private var rockets = [Rocket]()
    private var networkLayer: INetworkService?
    private lazy var arrayRocketControllers: [RocketSpaceXViewController] = {
        var vc = [RocketSpaceXViewController]()
        for index in rockets {
            vc.append(RocketSpaceXViewController(model: index))
        }
        return vc
    }()
    
    // MARK: - Init
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        
        networkLayer = NetworkService()
        networkLayer?.fetchResult(complition: { [weak self] item in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch item {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.rockets = data
                    
                    self.view.backgroundColor = .black
                    self.delegate = self
                    self.dataSource = self
                    self.setViewControllers(
                        [self.arrayRocketControllers[0]],
                        direction: .forward,
                        animated: true,
                        completion: nil
                    )
                }
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIPageViewControllerDelegate

extension FirstViewController: UIPageViewControllerDelegate { }

// MARK: - UIPageViewControllerDataSource

extension FirstViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketSpaceXViewController else { return nil }
        if let index = arrayRocketControllers.firstIndex(of: viewController) {
            if index > 0 {
                return arrayRocketControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? RocketSpaceXViewController else { return nil }
        if let index = arrayRocketControllers.firstIndex(of: viewController) {
            if index < rockets.count - 1 {
                return arrayRocketControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return rockets.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
