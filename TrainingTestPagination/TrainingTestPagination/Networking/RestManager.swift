//
//  ApiService.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 04/04/22.
//

import Foundation

class RestManager : NSObject {
    func fetchData<T: Codable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
          completion(.failure(error))
        }

        if let data = data {
          do {
            let object = try JSONDecoder().decode(T.self, from: data)
            completion(.success(object))
          } catch let decoderError {
            completion(.failure(decoderError))
          }
        }
      }.resume()
    }
}
