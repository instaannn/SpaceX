//
//  INetworkService.swift
//  SpaceX
//
//  Created by Анна Сычева on 18.08.2022.
//

//MARK: - INetworkService

protocol INetworkService {
    func fetchResult(complition: @escaping (Result<[Rocket], Error>) -> Void)
}
