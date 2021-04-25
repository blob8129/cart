//
//  ImagesService.swift
//  Cart
//
//  Created by Andrey Volobuev on 23/04/2021.
//

import Foundation

final class ImagesService {
    enum ImagesServiceError: Error {
        case unknown
    }
    
    func fetchImage(at url: URL, result: @escaping (Result<(URL, Data), Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                result(.failure(error ?? ImagesServiceError.unknown))
                return
            }
            result(.success((url, data)))
        }
        task.resume()
    }
}
