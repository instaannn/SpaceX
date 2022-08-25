//
//  NetworkService.swift
//  SpaceX
//
//  Created by Анна Сычева on 18.08.2022.
//

import Foundation

//MARK: - NetworkService

final class NetworkService: INetworkService {
    
    // MARK: - Public methods
    
    func fetchResult(complition: @escaping(Result<[Rocket], Error>) -> Void) {
        downloadJson(url: Url.urlRockets, complition: complition)
    }
    
    // MARK: - Private methods
    
    private func downloadJson<T: Decodable>(url: String, complition: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                complition(.success(object))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
